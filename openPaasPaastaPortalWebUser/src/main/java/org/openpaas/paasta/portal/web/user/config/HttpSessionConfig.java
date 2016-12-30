package org.openpaas.paasta.portal.web.user.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.session.data.redis.config.annotation.web.http.EnableRedisHttpSession;

/**
 * 스프링 세션을 설정하는 클레스
 * 기본 세션대신 Redis 를 이용하여 세션을 관리하도록 설정한다.
 *
 * @author 조민구
 * @version 1.0
 * @since 2016-05-09
 */
@Configuration
@EnableRedisHttpSession(maxInactiveIntervalInSeconds=3600)
public class HttpSessionConfig {
}
