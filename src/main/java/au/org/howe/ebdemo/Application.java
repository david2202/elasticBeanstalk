package au.org.howe.ebdemo;

import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;
import org.apache.tomcat.util.descriptor.web.ContextEnvironment;
import org.apache.tomcat.util.descriptor.web.ContextResource;
import org.apache.tomcat.util.descriptor.web.ContextResourceLink;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.embedded.tomcat.TomcatEmbeddedServletContainer;
import org.springframework.boot.context.embedded.tomcat.TomcatEmbeddedServletContainerFactory;
import org.springframework.boot.context.web.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Lazy;
import org.springframework.core.env.Environment;
import org.springframework.jndi.JndiObjectFactoryBean;

import javax.annotation.Resource;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

@SpringBootApplication
public class Application extends SpringBootServletInitializer {
    public static void main(String[] args) throws Exception {
        SpringApplication.run(Application.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Application.class);
    }

    @Bean
    public TomcatEmbeddedServletContainerFactory tomcatFactory() {
        return new TomcatEmbeddedServletContainerFactory() {

            @Override
            protected TomcatEmbeddedServletContainer getTomcatEmbeddedServletContainer(
                    Tomcat tomcat) {
                tomcat.enableNaming();
                return super.getTomcatEmbeddedServletContainer(tomcat);
            }

            @Override
            protected void postProcessContext(Context context) {
//                ContextResource resource = new ContextResource();
//                resource.setType(String.class.getName());
//                resource.setName("AP_ENV");
//                resource.setProperty("environment", "pdev");
//                context.getNamingResources().addResource(resource);

                ContextEnvironment environment = new ContextEnvironment();
                environment.setName("apEnvironment");
                environment.setType(String.class.getName());
                environment.setOverride(false);
                environment.setValue("pdev");
                context.getNamingResources().addEnvironment(environment);

//                ContextResourceLink resourceLink = new ContextResourceLink();
//                resourceLink.setName("AP_ENV");
//                resourceLink.setType(String.class.getName());
//                resourceLink.setGlobal("AP_ENV");

//                context.getNamingResources().addResourceLink(resourceLink);
            }
        };
    }

    @Bean
    @Lazy
    public javax.naming.Context environmentContext() throws NamingException {
        javax.naming.Context ctx = new InitialContext();
        javax.naming.Context envCtx = (javax.naming.Context) ctx.lookup("java:comp/env");
        return envCtx;
    }

    public String environment() throws IllegalArgumentException, NamingException {
        JndiObjectFactoryBean bean = new JndiObjectFactoryBean();
        bean.setJndiName("java:comp/env/AP_ENV");
        bean.setProxyInterface(DataSource.class);
        bean.setLookupOnStartup(true);
        bean.afterPropertiesSet();
        Object o = bean.getObject();
        return (String) bean.getObject();
    }
}
