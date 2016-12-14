package org.openpaas.paasta.portal.api.config.datasource;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * Data Configuration
 *
 * @author nawkm
 * @version 1.0
 * @since 2016.4.4 최초작성
 */

@Configuration
@EnableTransactionManagement
public class DataConfig {

    /**
     * ccdb Data source data source.
     *
     * @return the data source
     */
    @Bean(name = "ccDataSource", destroyMethod = "close")
    public DataSource ccDataSource(@Value("${datasource.cc.driverClassName}") String driverClassName,
                                   @Value("${datasource.cc.url}") String url,
                                   @Value("${datasource.cc.username}") String username,
                                   @Value("${datasource.cc.password}") String password) {
        return createDataSource(driverClassName, url, username, password);
    }
    @Bean(name = "ccTransactionManager")
    public PlatformTransactionManager ccTransactionManager(@Qualifier("ccDataSource") DataSource ccDataSource) {
        DataSourceTransactionManager transactionManager = new DataSourceTransactionManager(ccDataSource);
        transactionManager.setGlobalRollbackOnParticipationFailure(false);
        return transactionManager;
    }

    /**
     * portaldb Data source data source.
     *
     * @return the data source
     */
    @Bean(name = "portalDataSource", destroyMethod = "close")
    public DataSource portalDataSource(@Value("${datasource.portal.driverClassName}") String driverClassName,
                                       @Value("${datasource.portal.url}") String url,
                                       @Value("${datasource.portal.username}") String username,
                                       @Value("${datasource.portal.password}") String password) {
        return createDataSource(driverClassName, url, username, password);
    }
    @Bean(name = "portalTransactionManager")
    public PlatformTransactionManager portalTransactionManager(@Qualifier("portalDataSource") DataSource portalDataSource) {
        DataSourceTransactionManager transactionManager = new DataSourceTransactionManager(portalDataSource);
        transactionManager.setGlobalRollbackOnParticipationFailure(false);
        return transactionManager;
    }

    /**
     * uaadb Data source data source.
     *
     * @return the data source
     */
    @Primary
    @Bean(name = "uaaDataSource", destroyMethod = "close")
    public DataSource uaaDataSource(@Value("${datasource.uaa.driverClassName}") String driverClassName,
                                 @Value("${datasource.uaa.url}") String url,
                                 @Value("${datasource.uaa.username}") String username,
                                 @Value("${datasource.uaa.password}") String password) {
        return createDataSource(driverClassName, url, username, password);
    }
    @Primary
    @Bean(name = "uaaTransactionManager")
    public PlatformTransactionManager uaaTransactionManager(@Qualifier("uaaDataSource") DataSource uaaDataSource) {
        DataSourceTransactionManager transactionManager = new DataSourceTransactionManager(uaaDataSource);
        transactionManager.setGlobalRollbackOnParticipationFailure(false);
        return transactionManager;
    }

    /**
     * datsource 를 생성
     *
     * @param driverClassName
     * @param url
     * @param username
     * @param password
     * @return DataSource
     */
    private DataSource createDataSource(String driverClassName,
                                        String url,
                                        String username,
                                        String password) {
        DataSource dataSource = new DataSource();

        dataSource.setDriverClassName(driverClassName);
        dataSource.setUrl(url);
        dataSource.setUsername(username);
        dataSource.setPassword(password);

        return dataSource;
    }
}