package org.openpaas.paasta.portal.web.user.common;

import org.openpaas.paasta.common.security.userdetails.User;
import org.openpaas.paasta.portal.web.user.service.CommonService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.*;

/**
 * Common Class
 *
 * @author nawkm
 * @version 1.0
 * @since 2016.5.24
 */
public class Common {

    private static final Logger LOG = LoggerFactory.getLogger(Common.class);

    /**
     * Get Token
     *
     * @return string string
     */

    @Autowired
    public MessageSource messageSource;

    @Autowired
    public CommonService commonService;

    public String getToken(){
        User user = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        //token 만료 시간 비교
        if(user.getExpireDate() <= System.currentTimeMillis()){

            try{
                Map<String,Object> resBody = new HashMap();
                resBody.put("id", user.getUsername());
                resBody.put("password", user.getPassword());

                Map result;

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
    public static int diffDay(Date d, Date accessDate){
        /**
         * 날짜 계산
         */
        Calendar curC = Calendar.getInstance();
        Calendar accessC = Calendar.getInstance();
        curC.setTime(d);
        accessC.setTime(accessDate);
        accessC.compareTo(curC);
        int diffCnt = 0;
        while (!accessC.after(curC)) {
            diffCnt++;
            accessC.add(Calendar.DATE, 1); // 다음날로 바뀜
        }
        System.out.println("기준일로부터 " + diffCnt + "일이 지났습니다.");
        System.out.println(accessC.compareTo(curC));
        return diffCnt;
    }

    /**
     * 요청 파라미터들의 빈값 또는 null값 확인을 하나의 메소드로 처리할 수 있도록 생성한 메소드
     * 요청 파라미터 중 빈값 또는 null값인 파라미터가 있는 경우, false를 리턴한다.
     *
     * @param params
     * @return
     */
    public boolean stringNullCheck(String... params) {
        return Arrays.stream(params).allMatch(param -> null != param && !param.equals(""));
    }

}
