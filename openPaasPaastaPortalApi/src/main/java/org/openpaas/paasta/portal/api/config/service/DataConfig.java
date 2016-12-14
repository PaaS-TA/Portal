package org.openpaas.paasta.portal.api.config.service;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * Data Configuration
     *mail_smtp:
     server: smtp.gmail.com
     port: 465
     domain: gmail.com
     authentication: true
     username: openpasta@gmail.com
     password: openpasta!
 * @author nawkm
 * @version 1.0
 * @since 2016.4.4 최초작성
 */
public abstract class DataConfig {

    @Bean
    public abstract DataSource dataSource();

}

@Configuration
@EnableTransactionManagement
class CcDataConfig extends DataConfig {

    @Autowired
    private Environment env;

    /**
     * ccdb Data source data source.
     *
     * @return the data source
     */
    @Bean(name = "ccDataSource", destroyMethod = "close")
    public DataSource dataSource() {
        DataSource ccDataSource = new DataSource();

        ccDataSource.setDriverClassName(env.getRequiredProperty("spring.datasource.cc.driverClassName"));
        ccDataSource.setUrl(env.getRequiredProperty("spring.datasource.cc.url"));
        ccDataSource.setUsername(env.getRequiredProperty("spring.datasource.cc.username"));
        ccDataSource.setPassword(env.getRequiredProperty("spring.datasource.cc.password"));

        return ccDataSource;
    }

    @Bean(name = "ccTransactionManager")
    public PlatformTransactionManager transactionManager(@Qualifier("ccDataSource") DataSource ccDataSource) {
        DataSourceTransactionManager transactionManager = new DataSourceTransactionManager(ccDataSource);
        transactionManager.setGlobalRollbackOnParticipationFailure(false);
        return transactionManager;
    }
}

@Configuration
@EnableTransactionManagement
class PortalDataConfig extends DataConfig {

    @Autowired
    private Environment env;

    /**
     * portaldb Data source data source.
     *
     * @return the data source
     */
    @Bean(name = "portalDataSource", destroyMethod = "close")
    public DataSource dataSource() {
        DataSource portalDataSource = new DataSource();
        if("postgresql".equals(env.getRequiredProperty("spring.jdbc"))) {
            portalDataSource.setDriverClassName(env.getRequiredProperty("spring.datasource.portal.driverClassName"));
            portalDataSource.setUrl(env.getRequiredProperty("spring.datasource.portal.url"));
            portalDataSource.setUsername(env.getRequiredProperty("spring.datasource.portal.username"));
            portalDataSource.setPassword(env.getRequiredProperty("spring.datasource.portal.password"));

            return portalDataSource;
        }
        if("mysql".equals(env.getRequiredProperty("spring.jdbc"))) {
            portalDataSource.setDriverClassName(env.getRequiredProperty("spring.datasource.portal.mysql.driverClassName"));
            portalDataSource.setUrl(env.getRequiredProperty("spring.datasource.portal.mysql.url"));
            portalDataSource.setUsername(env.getRequiredProperty("spring.datasource.portal.mysql.username"));
            portalDataSource.setPassword(env.getRequiredProperty("spring.datasource.portal.mysql.password"));

            return portalDataSource;
        }
        portalDataSource.setDriverClassName(env.getRequiredProperty("spring.datasource.portal.driverClassName"));
        portalDataSource.setUrl(env.getRequiredProperty("spring.datasource.portal.url"));
        portalDataSource.setUsername(env.getRequiredProperty("spring.datasource.portal.username"));
        portalDataSource.setPassword(env.getRequiredProperty("spring.datasource.portal.password"));

        return portalDataSource;
    }

    @Bean(name = "portalTransactionManager")
    public PlatformTransactionManager transactionManager(@Qualifier("portalDataSource") DataSource portalDataSource) {
        DataSourceTransactionManager transactionManager = new DataSourceTransactionManager(portalDataSource);
        transactionManager.setGlobalRollbackOnParticipationFailure(false);
        return transactionManager;
    }
}

@Configuration
@EnableTransactionManagement
class UaaDataConfig extends DataConfig {

    @Autowired
    private Environment env;

    /**
     * uaadb Data source data source.
     *
     * @return the data source
     */
    @Primary
    @Bean(name = "uaaDataSource", destroyMethod = "close")
    public DataSource dataSource() {
        DataSource uaaDataSource = new DataSource();

        uaaDataSource.setDriverClassName(env.getRequiredProperty("spring.datasource.uaa.driverClassName"));
        uaaDataSource.setUrl(env.getRequiredProperty("spring.datasource.uaa.url"));
        uaaDataSource.setUsername(env.getRequiredProperty("spring.datasource.uaa.username"));
        uaaDataSource.setPassword(env.getRequiredProperty("spring.datasource.uaa.password"));

        return uaaDataSource;
    }

    @Primary
    @Bean(name = "uaaTransactionManager")
    public PlatformTransactionManager transactionManager(@Qualifier("uaaDataSource") DataSource uaaDataSource) {
        DataSourceTransactionManager transactionManager = new DataSourceTransactionManager(uaaDataSource);
        transactionManager.setGlobalRollbackOnParticipationFailure(false);
        return transactionManager;
    }
}