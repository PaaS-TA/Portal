package org.openpaas.paasta.portal.api.common;

import org.junit.Test;

import static org.junit.Assert.*;

/**
 * org.openpaas.paasta.portal.api.common
 *
 * @author rex
 * @version 1.0
 * @since 2016.09.01
 */
public class ConstantsTest {

    @Test
    public void test_01_constructor() throws Exception {
        Constants constants = new Constants();
        System.out.println(constants.toString());
    }
}