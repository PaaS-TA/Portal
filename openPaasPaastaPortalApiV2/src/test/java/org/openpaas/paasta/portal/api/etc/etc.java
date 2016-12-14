package org.openpaas.paasta.portal.api.etc;

import org.junit.Test;

import java.sql.Timestamp;

/**
 * Created by mg on 2016-08-16.
 */
public class etc {

    @Test
    public void timestamp() {
        Long timestamp = 1471323748499767124L/1000000;//767124

        Long currentTs = System.currentTimeMillis();

        Timestamp ts = new Timestamp(timestamp);

        ts.setTime(timestamp);

        System.out.println(ts.toLocalDateTime());
    }
}
