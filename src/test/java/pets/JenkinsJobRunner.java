package pets;

import com.intuit.karate.gatling.GatlingMavenJobConfig;
import com.intuit.karate.job.JobManager;
import org.junit.Test;

public class JenkinsJobRunner {

    @Test
    void testAll() {
        GatlingMavenJobConfig config = new GatlingMavenJobConfig(2, "hostname", 8080);
        JobManager manager = new JobManager(config);
        manager.start();
        manager.waitForCompletion();
    }
}
