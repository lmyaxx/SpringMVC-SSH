package com.dhu.util;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Util {
    static public Timestamp str2TimeStamp(String dates){
        Timestamp ts = new Timestamp(System.currentTimeMillis());
        try {
            DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
            System.out.println(dates);
            Date date = format1.parse(dates);
            ts.setTime(date.getTime());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ts;
    }
}
