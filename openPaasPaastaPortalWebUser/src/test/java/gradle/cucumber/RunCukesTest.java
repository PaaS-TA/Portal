package gradle.cucumber;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

/**
 * 쿠쿰버 테스트에 대해서 설정하는 클레스.
 * 어노테이션을 이용하여 쿠쿰버 테스트를 설정한다.
 *
 * @author 조민구
 * @version 1.0
 * @since 2016-08-18
 */
@RunWith(Cucumber.class)
@CucumberOptions(plugin = {"pretty"}, features = "src/test/resources")
public class RunCukesTest {
}