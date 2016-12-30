package org.openpaas.paasta.portal.web.user.config;

import org.springframework.boot.autoconfigure.web.ServerProperties;
import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.context.embedded.ErrorPage;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;

/**
 * 글로벌 에러 페이지를 설정한다.
 *
 * @author 조민구
 * @version 1.0
 * @since 2016-08-02
 */
@Configuration
public class ServerCustomization extends ServerProperties {

    @Override
    public void customize(ConfigurableEmbeddedServletContainer container) {
        super.customize(container);
//        container.addErrorPages(new ErrorPage(HttpStatus.valueOf(404), "/common/error/404"));
//        container.addErrorPages(new ErrorPage(HttpStatus.valueOf(403), "/common/error/403"));
//        container.addErrorPages(new ErrorPage(HttpStatus.valueOf(500), "/common/error/500"));
//        container.addErrorPages(new ErrorPage(HttpStatus.valueOf(503), "/common/error/503"));
//        container.addErrorPages(new ErrorPage(HttpStatus.valueOf(400), "/common/error/400"));
//        container.addErrorPages(new ErrorPage(HttpStatus.valueOf(405), "/common/error/405"));
//        container.addErrorPages(new ErrorPage("/common/error/throwable"));
    }

}
