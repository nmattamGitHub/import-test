package docker.example

import grails.boot.GrailsApp
import grails.boot.config.GrailsAutoConfiguration
import org.springframework.boot.system.ApplicationPidFileWriter

class Application extends GrailsAutoConfiguration {
    static void main(String[] args) {
        final GrailsApp app = new GrailsApp(Application)
        // Register PID file writer.
        app.addListeners(new ApplicationPidFileWriter())
        app.run(args)
    }
}