#!groovy

import jenkins.model.*
import hudson.model.UpdateSite
import java.util.logging.Logger
import java.io.File
import java.io.FileNotFoundException
import groovy.lang.MissingPropertyException

def logger = Logger.getLogger("install_plugins")

try {

    def env = System.getenv()

    def installed = false

    def initialized = false

    def File file

    def pathToPluginsList = env['PLUGINS_LIST']

    if (!pathtoPluginsLists) {

       logger.info("No plugins list found")
       return
    }

    file = new File(pathToPluginsList)

    def plugins = file.readLines()

    logger.info("" + plugins)

    def instance = Jenkins.getInstance()

    def pm = instance.getPluginManager()

    def uc = instance.getUpdateCenter()

    def sites = uc.getSiteList()

    sites.each {

        def UpdateSite site = it
        logger.info("Update Centers: " + sites.getUrl())
    }

    plugins.each {

        logger.info("Checking " + it)
        
        if (!pm.getPlugin(it)) {

            logger.info("Looking in UpdateCenter for " + it)

            if(!initialized) {
                uc.updateAllSites()
                initialized = true
            }

            def plugin = uc.getPlugin(it)

            if (plugin) {

                logger.info("Installing " + it)

                def installFuture = plugin.deploy()

                while (!installFuture.isDone()) {

                    logger.info("Waiting for plugin install: " + it)

                    sleep(3000)

                    installed = true
                }
            }
 
        }
    }

    if (installed) {

        logger.info("Plugins installed, initializing a restart")

        instance.save()

        instance.restart()
    }

} catch (FileNotFoundException fnfe) {

    logger.info("Plugin List File not found " + fnfe.getMessage())

} catch (MissingPropertyException mpe) {

    logger.info("PLUGINS_LIST Property not set " + mpe.getMessage())

} catch (Exception e) {

    logger.info("Error occured " + e.getMessage())

}



