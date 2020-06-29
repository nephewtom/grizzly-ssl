package com.ericsson.sm2m;

import org.glassfish.grizzly.http.server.*;
import org.glassfish.grizzly.ssl.SSLContextConfigurator;
import org.glassfish.grizzly.ssl.SSLEngineConfigurator;
import org.glassfish.jersey.grizzly2.httpserver.GrizzlyHttpServerFactory;
import org.glassfish.jersey.server.ResourceConfig;

import javax.net.ssl.SSLContext;
import java.net.URI;

public class MyGrizzlyServer {

    public static void main(String[] args) throws Exception {

        System.out.println("Hello main!");
        String uriStr = "https://0.0.0.0:9999/";
        URI uri = URI.create(uriStr);
        final ResourceConfig rc = new ResourceConfig().packages("com.ericsson.sm2m");
        HttpServer server = GrizzlyHttpServerFactory.createHttpServer(uri, rc, false);

        SSLEngineConfigurator engineConfig = getSslEngineConfig();

        for (NetworkListener listener : server.getListeners()) {

            listener.setSecure(true);
            listener.setSSLEngineConfig(engineConfig);

            //TCPNIOTransport transport = listener.getTransport();
            //Processor processor = transport.getProcessor();

            //FilterChain filterChain = listener.getFilterChain();
            //FilterChain.getClass();
            //HttpServerFilter filter = listener.getHttpServerFilter();
        }

        HttpHandler handler = server.getHttpHandler();

        System.out.println("Http server start...");
        server.start();
        System.out.println("Hit enter to stop it...");
        System.in.read();
        server.shutdownNow();
    }

    private static SSLEngineConfigurator getSslEngineConfig() {

        SSLContextConfigurator sslConfigurator = new SSLContextConfigurator();

        sslConfigurator.setKeyStoreFile("./mycerts/grizzly.jks");
        sslConfigurator.setKeyStorePass("awesome");
        sslConfigurator.setTrustStoreFile("./mycerts/myCA.jks");
        sslConfigurator.setTrustStorePass("mycapass");
        sslConfigurator.setSecurityProtocol("TLS");

        SSLContext context = sslConfigurator.createSSLContext(true);
        SSLEngineConfigurator sslEngineConfigurator = new SSLEngineConfigurator(context);
        sslEngineConfigurator.setNeedClientAuth(true);
        sslEngineConfigurator.setClientMode(false);
        return sslEngineConfigurator;
    }
}

