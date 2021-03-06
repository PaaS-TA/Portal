package org.openpaas.paasta.portal.web.admin.common;

import org.openpaas.paasta.common.security.userdetails.User;
import org.openpaas.paasta.portal.web.admin.service.CommonService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

/**
 * Common Class
 *
 * @author nawkm
 * @version 1.0
 * @since 2016.5.24
 */
public class Common {

    private static final Logger LOG = LoggerFactory.getLogger(Common.class);

    @Autowired
    public CommonService commonService;
    /**
     * Get Token
     *
     * @return string string
     */

    @Autowired
    public MessageSource messageSource;

    @Autowired
    protected RestTemplate restTemplate;

    public String getToken(){
        User user = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        //token 만료 시간 비교
        if(user.getExpireDate() <= System.currentTimeMillis()){

            try{
                Map<String,Object> resBody = new HashMap();
                resBody.put("id", user.getUsername());
                resBody.put("password", user.getPassword());

                Map result;

                /*
                HttpEntity requestEntity = new HttpEntity(resBody);
                ResponseEntity rssResponse = restTemplate.exchange(
                        apiUrl + "/login",
                        HttpMethod.POST,
                        requestEntity,
                        Map.class);

                result = (Map)rssResponse.getBody();
*/
                result = commonService.procRestTemplate("/login", HttpMethod.POST, resBody, null);

                user.setToken((String)result.get("token"));
                user.setExpireDate((Long)result.get("expireDate"));

                // session에 적용
                Authentication authentication = new UsernamePasswordAuthenticationToken(user, user.getPassword(), user.getAuthorities());
                SecurityContextHolder.getContext().setAuthentication(authentication);

                LOG.info("new token : " + user.getToken());

            } catch (Exception e) {
                throw new BadCredentialsException(e.getMessage());
            }
        }

        LOG.info("############################# Expires In : " + (user.getExpireDate() - System.currentTimeMillis())/1000 + " sec");

        String token = user.getToken();

        return token ;
    }
}
