package com.geocompass.snmapboxdemo;

import android.Manifest;
import android.annotation.SuppressLint;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.graphics.PointF;
import android.location.Location;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.Settings;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.app.AppCompatDelegate;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;

import com.google.gson.JsonElement;
import com.mapbox.mapboxsdk.annotations.IconFactory;
import com.mapbox.mapboxsdk.annotations.Marker;
import com.mapbox.mapboxsdk.annotations.MarkerOptions;
import com.mapbox.mapboxsdk.annotations.Polygon;
import com.mapbox.mapboxsdk.annotations.PolygonOptions;
import com.mapbox.mapboxsdk.annotations.Polyline;
import com.mapbox.mapboxsdk.annotations.PolylineOptions;
import com.mapbox.mapboxsdk.camera.CameraPosition;
import com.mapbox.mapboxsdk.camera.CameraUpdateFactory;
import com.mapbox.mapboxsdk.geometry.LatLng;
import com.mapbox.mapboxsdk.maps.MapView;
import com.mapbox.mapboxsdk.maps.MapboxMap;
import com.mapbox.mapboxsdk.maps.OnMapReadyCallback;
import com.mapbox.mapboxsdk.plugins.locationlayer.LocationLayerMode;
import com.mapbox.mapboxsdk.plugins.locationlayer.LocationLayerPlugin;
import com.mapbox.mapboxsdk.style.functions.Function;
import com.mapbox.mapboxsdk.style.functions.stops.Stops;
import com.mapbox.mapboxsdk.style.layers.CircleLayer;
import com.mapbox.mapboxsdk.style.layers.FillExtrusionLayer;
import com.mapbox.mapboxsdk.style.layers.FillLayer;
import com.mapbox.mapboxsdk.style.layers.LineLayer;
import com.mapbox.mapboxsdk.style.layers.RasterLayer;
import com.mapbox.mapboxsdk.style.layers.SymbolLayer;
import com.mapbox.mapboxsdk.style.sources.GeoJsonSource;
import com.mapbox.mapboxsdk.style.sources.RasterSource;
import com.mapbox.mapboxsdk.style.sources.TileSet;
import com.mapbox.mapboxsdk.style.sources.VectorSource;
import com.mapbox.mapboxsdk.utils.JSONResourceUtils;
import com.mapbox.services.android.telemetry.location.AndroidLocationEngine;
import com.mapbox.services.android.telemetry.location.LocationEngine;
import com.mapbox.services.android.telemetry.location.LocationEnginePriority;
import com.mapbox.services.commons.geojson.Feature;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import static com.mapbox.mapboxsdk.style.layers.PropertyFactory.circleColor;
import static com.mapbox.mapboxsdk.style.layers.PropertyFactory.circleStrokeWidth;
import static com.mapbox.mapboxsdk.style.layers.PropertyFactory.fillColor;
import static com.mapbox.mapboxsdk.style.layers.PropertyFactory.fillExtrusionColor;
import static com.mapbox.mapboxsdk.style.layers.PropertyFactory.fillExtrusionHeight;
import static com.mapbox.mapboxsdk.style.layers.PropertyFactory.fillExtrusionOpacity;
import static com.mapbox.mapboxsdk.style.layers.PropertyFactory.fillOpacity;
import static com.mapbox.mapboxsdk.style.layers.PropertyFactory.fillOutlineColor;
import static com.mapbox.mapboxsdk.style.layers.PropertyFactory.lineColor;
import static com.mapbox.mapboxsdk.style.layers.PropertyFactory.lineWidth;
import static com.mapbox.mapboxsdk.style.layers.PropertyFactory.textField;

public class MainActivity extends AppCompatActivity implements
        OnMapReadyCallback, MapboxMap.OnMapClickListener,
        View.OnClickListener, MapboxMap.InfoWindowAdapter {

    //permissions
    private static String[] mPermissions = new String[]{
            Manifest.permission.READ_EXTERNAL_STORAGE,
            Manifest.permission.ACCESS_FINE_LOCATION
    };

    private int mPermissionIndex = 0;

    private MapboxMap mMap;
    private MapView mMapView;
    private ImageButton mIBMyLocation;
    private Button mBtnSelectFeature, mBtnAddMarker;

    private static final int ACTION_NORMAL = 0x2001;
    private static final int ACTION_SELECT = 0x2002;
    private static final int ACTION_MARKER = 0x2003;
    private int mCurAction = ACTION_NORMAL;
    private Polygon mSelectedArea;
    private  LocationLayerPlugin mLocationPlugin;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mMapView = (MapView) findViewById(R.id.map_view);
        mMapView.onCreate(savedInstanceState);
        mMapView.getMapAsync(this);

        mIBMyLocation = (ImageButton) findViewById(R.id.iv_my_location);
        mBtnAddMarker = (Button) findViewById(R.id.btn_add_marker);
        mBtnSelectFeature = (Button) findViewById(R.id.btn_select_feature);

        mIBMyLocation.setOnClickListener(this);
        mBtnAddMarker.setOnClickListener(this);
        mBtnSelectFeature.setOnClickListener(this);

    }

    @SuppressLint("MissingPermission")
    @Override
    protected void onStart() {
        super.onStart();
        if(mLocationPlugin!=null){
            mLocationPlugin.onStart();
        }
    }

    @Override
    protected void onStop() {
        super.onStop();
        if(mLocationPlugin!=null){
            mLocationPlugin.onStop();
        }
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.iv_my_location:
                @SuppressLint("MissingPermission")
                 Location location =  mLocationPlugin.getLocationEngine().getLastLocation();
                if (location != null)
                    mMap.animateCamera(CameraUpdateFactory.newLatLng(new LatLng(location.getLatitude(), location.getLongitude())));
                break;
            case R.id.btn_add_marker:
                if (mCurAction != ACTION_MARKER) {
                    mCurAction = ACTION_MARKER;
                    mBtnAddMarker.setBackgroundResource(R.color.colorActived);
                } else {
                    mCurAction = ACTION_NORMAL;
                    mBtnAddMarker.setBackgroundResource(R.color.colorNormal);
                }
                mBtnSelectFeature.setBackgroundResource(R.color.colorNormal);
                break;
            case R.id.btn_select_feature:
                if (mCurAction != ACTION_SELECT) {
                    mCurAction = ACTION_SELECT;
                    mBtnSelectFeature.setBackgroundResource(R.color.colorActived);
                } else {
                    mCurAction = ACTION_NORMAL;
                    mBtnSelectFeature.setBackgroundResource(R.color.colorNormal);
                }
                mBtnAddMarker.setBackgroundResource(R.color.colorNormal);
                break;
        }
    }

    @Override
    public void onMapReady(MapboxMap mapboxMap) {
        if(mapboxMap==null)return;
        this.mMap = mapboxMap;
//        try {
//            String styleJson = ResourceUtils.readRawResource(this, R.raw.tdt);
//            mMap.setStyleJson(styleJson);
            mMap.setStyleUrl("http://vectortile.geo-compass.com/api/v1/styles/xjl/S1sAm_VNz/publish?access_key=7c611870843304ad94ce4df5afed4d5f");
//        } catch (IOException e) {
//            e.printStackTrace();
//        }

        AppCompatDelegate.setCompatVectorFromResourcesEnabled(true);
        mMap.setOnMapClickListener(MainActivity.this);
        mMap.getUiSettings().setRotateGesturesEnabled(false);
        mMap.setInfoWindowAdapter(this);
//        mMap.setMapType(MapboxMap.MAP_TYPE_NORMAL);
        mMap.setInfoWindowAdapter(this);
//        addWmtsLayer();
        checkNextPermission();
    }

    @Override
    public void onMapClick(@NonNull LatLng point) {
        switch (mCurAction) {
            case ACTION_NORMAL:
                break;
            case ACTION_SELECT:
                selectFeature(point);
                break;
            case ACTION_MARKER:
                addMarker(point);
                break;
        }
    }

    /**
     * 加载离线瓦片地图
     */
    private void addMBTileData() {
        String rootDir = Environment.getExternalStorageDirectory().getAbsolutePath();
        String dbPath = rootDir + "/img_beijing.db";
        TileSet tileSet = new TileSet("tileset", "mbtile://path=" + dbPath + "&x={x}&y={y}&z={z}");
        tileSet.setMinZoom(1);
        tileSet.setMaxZoom(16);
        tileSet.setBounds(115f, 37f, 117f, 41f);
        RasterSource rasterSource = new RasterSource("mbtile", tileSet, 256);
        mMap.addSource(rasterSource);
        RasterLayer layer = new RasterLayer("mbtile_layer", "mbtile");
        mMap.addLayerAt(layer,3);
//
        dbPath = rootDir + "/cia_beijing.db";
        TileSet tileSet1 = new TileSet("tileset1", "mbtile://path=" + dbPath + "&x={x}&y={y}&z={z}");
        RasterSource rasterSource1 = new RasterSource("mbtile1", tileSet1, 256);
        mMap.addSource(rasterSource1);
        RasterLayer layer1 = new RasterLayer("mbtile_layer1", "mbtile1");
        mMap.addLayerAt(layer1,4);
    }

    /**
     * 加载在线 wmts 服务
     */
    private void addWmtsLayer() {
        TileSet tileSet = new TileSet("tile_esri_china", "http://map.geoq.cn/ArcGIS/rest/services/ChinaOnlineStreetPurplishBlue/MapServer/tile/{z}/{y}/{x}");
        RasterSource rasterSource = new RasterSource("ESRI_CHINA_BLUE_MAP", tileSet, 256);
        mMap.addSource(rasterSource);
        RasterLayer layer = new RasterLayer("ESRI_CHINA_BLUE_MAP", "ESRI_CHINA_BLUE_MAP");
        mMap.addLayer(layer);
    }

    /**
     * 添加一个标注
     */
    private void addMarker() {
        MarkerOptions marker = new MarkerOptions()
                .position(new LatLng(40, 116))
                .title("marker")
                .snippet("snippet")
                .icon(IconFactory.getInstance(this).fromResource(R.mipmap.ic_launcher_round));
        mMap.addMarker(marker);
    }

    /**
     * 手动添加标注
     * @param point
     */
    private void addMarker(LatLng point) {
        MarkerOptions marker = new MarkerOptions()
                .position(point)
                .title("marker")
                .snippet("snippet");
        mMap.addMarker(marker);
    }

    /**
     * 绘制一条线
     */
    private void addPolyline() {
        LatLng[] points = new LatLng[]{
                new LatLng(39, 114),
                new LatLng(39, 116),
                new LatLng(37, 116),
                new LatLng(37, 114),
                new LatLng(39, 114),
        };
        List<LatLng> pointList = Arrays.asList(points);

        Polyline polyline = mMap.addPolyline(new PolylineOptions()
                .addAll(pointList).alpha(0.5f)
                .color(Color.parseColor("#ffff00"))
                .width(3.0f));

    }

    /**
     * 绘制一个面
     */
    private void addPolygon() {
        LatLng[] points = new LatLng[]{
                new LatLng(39, 114),
                new LatLng(39, 116),
                new LatLng(37, 116),
                new LatLng(37, 114)
        };
        List<LatLng> pointList = Arrays.asList(points);

        Polygon polygon = mMap.addPolygon(new PolygonOptions()
                .addAll(pointList).alpha(0.5f)
                .fillColor(Color.parseColor("#ffff00"))
                .strokeColor(Color.parseColor("#0000ff")));

    }

    /**
     * 显示本地GeoJSON数据
     */
    private void addGeojson() {
        try {
            String geoJson = JSONResourceUtils.readRawResource(this, R.raw.cunjie);
            GeoJsonSource urbanAreasSource = new GeoJsonSource("bainjie", geoJson);
//        GeoJsonSource urbanAreasSource = new GeoJsonSource("urban-areas", geoJsonUrl);
            mMap.addSource(urbanAreasSource);
            FillLayer urbanArea = new FillLayer("urban-areas-fill", "bainjie");

            urbanArea.setProperties(
                    fillOpacity(0.3f),
                    fillColor(Color.parseColor("#ffff00")),
                    fillOutlineColor(Color.parseColor("#00ff00"))
            );
            mMap.addLayerAbove(urbanArea, "mbtile_layer1"); //地图默认自带绘制annotation的图层，新图层应该放在其下面
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    //添加3DJSON 数据
    private void add3DData() {
        GeoJsonSource courseRouteGeoJson = new GeoJsonSource("coursedata", loadJsonFromAsset("marathon_route.geojson"));
        mMap.addSource(courseRouteGeoJson);
        FillExtrusionLayer courseExtrusionLayer = new FillExtrusionLayer("course", "coursedata");
        courseExtrusionLayer.setProperties(
                fillExtrusionColor(Color.YELLOW),
                fillExtrusionOpacity(0.7f),
                fillExtrusionHeight(Function.property("e", Stops.<Float>identity()))
        );
        mMap.addLayer(courseExtrusionLayer);
    }

    /**
     * 选择要素
     */
    private void selectFeature(LatLng point) {
        final PointF pixel = mMap.getProjection().toScreenLocation(point);
        List<Feature> features = mMap.queryRenderedFeatures(pixel);
        if (mSelectedArea != null) {
            mSelectedArea.remove();
            mSelectedArea = null;
        }
        if (features.size() > 0) {
            Feature feature = features.get(0);

            StringBuilder stringBuilder = new StringBuilder();
            if (feature.getProperties() != null) {
                for (Map.Entry<String, JsonElement> entry : feature.getProperties().entrySet()) {
                    stringBuilder.append(String.format("%s - %s", entry.getKey(), entry.getValue()));
                    stringBuilder.append(System.getProperty("line.separator"));
                }
            }

            //选中状态
            if (feature.getGeometry() instanceof com.mapbox.services.commons.geojson.Polygon) {
                List<LatLng> list = new ArrayList<>();
                for (int i = 0; i < ((com.mapbox.services.commons.geojson.Polygon) feature.getGeometry()).getCoordinates().size(); i++) {
                    for (int j = 0; j < ((com.mapbox.services.commons.geojson.Polygon) feature.getGeometry()).getCoordinates().get(i).size(); j++) {
                        list.add(new LatLng(
                                ((com.mapbox.services.commons.geojson.Polygon) feature.getGeometry()).getCoordinates().get(i).get(j).getLatitude(),
                                ((com.mapbox.services.commons.geojson.Polygon) feature.getGeometry()).getCoordinates().get(i).get(j).getLongitude()
                        ));
                    }
                }
                mSelectedArea = mMap.addPolygon(new PolygonOptions()
                        .addAll(list)
                        .fillColor(Color.parseColor("#8A8ACB")));
            }
        }
    }


    private String loadJsonFromAsset(String filename) {
        // Using this method to load in GeoJSON files from the assets folder.
        try {
            InputStream is = getAssets().open(filename);
            int size = is.available();
            byte[] buffer = new byte[size];
            is.read(buffer);
            is.close();
            return new String(buffer, "UTF-8");
        } catch (IOException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    //权限检查
    private void checkNextPermission() {
        if (mPermissionIndex > mPermissions.length - 1) {
            //可以使用地图了
            onPermissionReady();
            return;
        }
        if (ContextCompat.checkSelfPermission(this, mPermissions[mPermissionIndex]) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, new String[]{
                    mPermissions[mPermissionIndex]
            }, mPermissionIndex);
        } else {
            mPermissionIndex++;
            checkNextPermission();
        }

    }

    /**
     * 添加自己发布的苏州矢量瓦片
     * 图层:苏州点线面
     */
    private void addSuzhouVectorSource() {
        String rootDir = Environment.getExternalStorageDirectory().getAbsolutePath();
        TileSet tileSet = new TileSet("2.1.0","file://"+rootDir+"/suzhou/{z}_{x}_{y}.pbf");
        //TileSet tileSet = new TileSet("2.1.0","file:///storage/emulated/0/suzhou/{z}_{x}_{y}.pbf");
        VectorSource vectorSource = new VectorSource("suzhou",tileSet);
        mMap.addSource(vectorSource);
        CircleLayer circleLayer = new CircleLayer("points","suzhou");
        circleLayer.setSourceLayer("points");
        circleLayer.setProperties(circleColor("#ff0000"),circleStrokeWidth(0.1f));
        LineLayer lineLayer = new LineLayer("roads","suzhou");
        lineLayer.setSourceLayer("roads");
        lineLayer.setProperties(lineColor("#F79709"),lineWidth(2f));
        FillLayer buildingLayer = new FillLayer("buildings","suzhou");
        buildingLayer.setSourceLayer("buildings");
        buildingLayer.setProperties(fillColor("#000000"),fillOutlineColor("#ff0000"));
        //circleLayer.setProperties(circleColor(Color.RED),circleStrokeWidth(2f));

        SymbolLayer symbolLayer = new SymbolLayer("points_label","suzhou");
        symbolLayer.setSourceLayer("points");
        symbolLayer.setProperties(textField("{gid}"));


        mMap.addLayer(buildingLayer);
        mMap.addLayer(lineLayer);
        mMap.addLayer(circleLayer);
        mMap.addLayer(symbolLayer);

        CameraPosition cameraPosition = new CameraPosition.Builder()
                .target(new LatLng(31.282484850000003,120.67252515000001))
                .zoom(5)
                .build();
        mMap.setCameraPosition(cameraPosition);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (grantResults.length == 0) return;
        //没有文件读写权限
        if (grantResults[0] != PackageManager.PERMISSION_GRANTED) {
            new AlertDialog.Builder(MainActivity.this)
                    .setTitle("警告！")
                    .setMessage("您没有授权App必要权限")
                    .setPositiveButton("设置", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialogInterface, int i) {
                            //打开应用设置
                            Uri packageURI = Uri.parse("package:" + "com.geocompass.mapdemo");
                            Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, packageURI);
                            startActivityForResult(intent, 1);
                        }
                    })
                    .setNegativeButton("关闭", null).create().show();
        } else {
            mPermissionIndex++;
            checkNextPermission();
        }

    }

    private void onPermissionReady() {
//        addMBTileData();
//        addPolygon();
//        addPolyline();
//        addMarker();
//        addGeojson();
//        add3DData();
//        addSuzhouVectorSource();
        startLocation();
    }

    private void startLocation(){
        LocationEngine locationEngine = AndroidLocationEngine.getLocationEngine(this);
        mLocationPlugin = new LocationLayerPlugin(mMapView, mMap, locationEngine);
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            return;
        }
        locationEngine.setFastestInterval(10);
        locationEngine.setPriority(LocationEnginePriority.HIGH_ACCURACY);
        mLocationPlugin.setLocationLayerEnabled(LocationLayerMode.COMPASS);
        locationEngine.activate();
    }

    /***
     * 自定义InfoWindow
     * @param marker The marker the user clicked on.
     * @return
     */
    @Nullable
    @Override
    public View getInfoWindow(@NonNull Marker marker){
        View view = LayoutInflater.from(this).inflate(R.layout.marker_info_window,null);
        return view;
    }
}
