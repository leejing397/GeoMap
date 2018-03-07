package com.geocompass.snmapboxdemo;

import android.support.multidex.MultiDex;
import android.support.multidex.MultiDexApplication;

import com.mapbox.mapboxsdk.Mapbox;

/**
 * Created by gxsn on 2017/11/8.
 */

public class SNApplication extends MultiDexApplication{
    private static final String DEFAULT_MAPBOX_ACCESS_TOKEN = "YOUR_MAPBOX_ACCESS_TOKEN_GOES_HERE";
    private static final String ACCESS_TOKEN_NOT_SET_MESSAGE = "In order to run the Test App you need to set a valid ";

    @Override
    public void onCreate() {
        super.onCreate();
//        String mapboxAccessToken = TokenUtils.getMapboxAccessToken(getApplicationContext());
//        if (TextUtils.isEmpty(mapboxAccessToken) || mapboxAccessToken.equals(DEFAULT_MAPBOX_ACCESS_TOKEN)) {
//            Timber.e(ACCESS_TOKEN_NOT_SET_MESSAGE);
//        }

        MultiDex.install(this);
        Mapbox.getInstance(getApplicationContext(), "pk.eyJ1IjoiZGFybHVuIiwiYSI6ImNqOGw4bWhsYjBremMyd211amlzcWZ6YjIifQ.LtIYFlm7FPMUKQuHSfdNSw");
    }
}
