package com;

import com.intuit.karate.gatling.GatlingMavenJobConfig;
import com.intuit.karate.job.JobManager;

import java.io.File;
import java.util.Arrays;

public class DockerRunner {

    public static void main(String[] args) {

        // note that on a mac docker (desktop) needs around 4 GB memory to be allocated for 2 parallel instances
     /*   GatlingMavenJobConfig config = new GatlingMavenJobConfig(2, "hostname", 2375);
        JobManager manager = new JobManager(config);
        manager.start();
        manager.waitForCompletion();*/
/*        String mavenHome = System.getProperty("user.home") + File.separator + ".m2";
        GatlingMavenJobConfig config = new GatlingMavenJobConfig(2, "host.docker.internal", 0);
        config.setAddOptions("-v " + mavenHome + ":/root/.m2");
        JobManager manager = new JobManager(config);
        manager.start();
        manager.waitForCompletion();*/

        String a = "GET https://www.beinconnect.com.tr/ HTTP/1.1\n" +
                "Host: www.beinconnect.com.tr\n" +
                "Connection: keep-alive\n" +
                "sec-ch-ua: \"Google Chrome\";v=\"89\", \"Chromium\";v=\"89\", \";Not A Brand\";v=\"99\"\n" +
                "sec-ch-ua-mobile: ?0\n" +
                "Upgrade-Insecure-Requests: 1\n" +
                "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36\n" +
                "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9\n" +
                "Sec-Fetch-Site: none\n" +
                "Sec-Fetch-Mode: navigate\n" +
                "Sec-Fetch-User: ?1\n" +
                "Sec-Fetch-Dest: document\n" +
                "Accept-Encoding: gzip, deflate, br\n" +
                "Accept-Language: tr-TR,tr;q=0.9,en-US;q=0.8,en;q=0.7";

        String [] arrays = a.split("\n");


        for (String array : arrays) {
            String [] temp = array.split(":");
            temp[0] = temp[0].replace("\"", "\\\"");
            temp[1] = temp[1].replace("\"", "\\\"");

            System.out.println("\"" + temp[0] + "\"->\"" + temp[1].substring(1) + "\"");


        }


    }
}
