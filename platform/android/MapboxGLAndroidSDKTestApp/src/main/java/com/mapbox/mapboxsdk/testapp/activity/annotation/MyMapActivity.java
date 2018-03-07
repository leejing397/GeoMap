package com.mapbox.mapboxsdk.testapp.activity.annotation;

import android.graphics.Color;
import android.graphics.PointF;
import android.os.Bundle;
import android.os.Environment;
import android.support.annotation.NonNull;
import android.support.annotation.RawRes;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.gson.JsonElement;
import com.mapbox.mapboxsdk.annotations.MarkerOptions;
import com.mapbox.mapboxsdk.annotations.PolygonOptions;
import com.mapbox.mapboxsdk.camera.CameraUpdate;
import com.mapbox.mapboxsdk.camera.CameraUpdateFactory;
import com.mapbox.mapboxsdk.geometry.LatLng;
import com.mapbox.mapboxsdk.geometry.LatLngBounds;
import com.mapbox.mapboxsdk.maps.MapboxMap;
import com.mapbox.mapboxsdk.maps.MapView;
import com.mapbox.mapboxsdk.maps.OnMapReadyCallback;
import com.mapbox.mapboxsdk.style.layers.CircleLayer;
import com.mapbox.mapboxsdk.style.layers.FillLayer;
import com.mapbox.mapboxsdk.style.layers.Filter;
import com.mapbox.mapboxsdk.style.layers.Layer;
import com.mapbox.mapboxsdk.style.layers.RasterLayer;
import com.mapbox.mapboxsdk.style.sources.GeoJsonSource;
import com.mapbox.mapboxsdk.style.sources.RasterSource;
import com.mapbox.mapboxsdk.style.sources.TileSet;
import com.mapbox.mapboxsdk.testapp.R;
import com.mapbox.mapboxsdk.testapp.utils.ResourceUtils;
import com.mapbox.services.commons.geojson.Feature;
import com.mapbox.services.commons.geojson.Polygon;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import timber.log.Timber;

import static com.mapbox.mapboxsdk.style.layers.PropertyFactory.fillColor;
import static com.mapbox.mapboxsdk.style.layers.PropertyFactory.fillOpacity;
import static com.mapbox.mapboxsdk.style.layers.PropertyFactory.fillOutlineColor;

public class MyMapActivity extends AppCompatActivity implements OnMapReadyCallback, MapboxMap.OnMapClickListener, View.OnClickListener {
    private MapView mMapView;
    private MapboxMap mMap;
    private com.mapbox.mapboxsdk.annotations.Polygon mSelectedBuilding;
    private ListView mVillagesListView;
    private List<Feature> mSelectFeatures;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_map);
        mMapView = (MapView) findViewById(R.id.map_view);
        mMapView.onCreate(savedInstanceState);
        mMapView.getMapAsync(this);
        mVillagesListView = (ListView) findViewById(R.id.list_village);
        findViewById(R.id.btn_switch_map_type).setOnClickListener(this);
        findViewById(R.id.btn_query_features).setOnClickListener(this);

    }

    @Override
    public void onMapReady(MapboxMap mapboxMap) {
        mMap = mapboxMap;
        if (mMap == null) return;
        mMap.getUiSettings().setRotateGesturesEnabled(false);//关闭旋转手势
        mMap.setOnMapClickListener(this);
        mMap.removeTdtLayer();
        addMBTileData();
//        addOfflineTDTLayer();
//        addJSONData();
        addMarker();
    }

    private void addMBTileData(){
        String rootDir = Environment.getExternalStorageDirectory().getAbsolutePath();
        String dbPath = rootDir+"/img_beijing.db";
        TileSet tileSet = new TileSet("tileset", "mbtile://path=" + dbPath + "&x={x}&y={y}&z={z}");
        RasterSource rasterSource = new RasterSource("mbtile",tileSet,256);
        mMap.addSource(rasterSource);
        RasterLayer layer = new RasterLayer("mbtile_layer","mbtile");
        mMap.addLayer(layer);

//         dbPath = rootDir+"/cva_w.db";
//        TileSet tileSet1 = new TileSet("tileset1", "mbtile://path=" + dbPath + "&x={x}&y={y}&z={z}");
//        RasterSource rasterSource1 = new RasterSource("mbtile1",tileSet1,256);
//        mMap.addSource(rasterSource1);
//        RasterLayer layer1   = new RasterLayer("mbtile_layer1","mbtile1");
//        mMap.addLayer(layer1 );
    }

    private void addMarker(){
        MarkerOptions marker = new MarkerOptions()
                .position(new LatLng(40,116))
                .title("marker")
                .snippet("snippet");
        mMap.addMarker(marker);
    }


    /**
     * 加载天地图
     */
    private void addOfflineTDTLayer() {
        List<Layer> layers = mMap.getLayers();

        String rootDir = Environment.getExternalStorageDirectory().getAbsolutePath();
        TileSet tileSet = new TileSet("tileset", "file://" + rootDir + "/tdt/img_w_{z}_{x}_{y}.png");
        RasterSource webMapSource2 = new RasterSource(
                "tdt_offline_name", tileSet
                , 256);
        mMap.addSource(webMapSource2);
        // Add the web map source to the map.
        RasterLayer tdtLayer2 = new RasterLayer("tdt_img_layer_offline", "tdt_offline_name");
        mMap.addLayer(tdtLayer2);
    }


    /**
     * 加载GeoJSON数据
     */
    private void addJSONData() {
        try {
            String rootDir = Environment.getExternalStorageDirectory().getAbsolutePath();
//            URL geoJsonUrl = new URL("file://"+rootDir+"/local.json");
            URL geoJsonUrl = new URL("https://d2ad6b4ur7yvpq.cloudfront.net/naturalearth-3.3.0/ne_110m_admin_1_states_provinces_shp.geojson");
            GeoJsonSource urbanAreasSource = new GeoJsonSource("urban-areas", geoJsonUrl);
            mMap.addSource(urbanAreasSource);
            FillLayer urbanArea = new FillLayer("urban-areas-fill", "urban-areas");

            urbanArea.setProperties(
                    fillColor(Color.parseColor("#ff0088")),
                    fillOpacity(0.4f),
                    fillOutlineColor(Color.parseColor("#0000ff"))
            );
            mMap.addLayer(urbanArea);
        } catch (MalformedURLException malformedUrlException) {
            malformedUrlException.printStackTrace();
        }
    }

    protected void testFeatureFromResource(final @RawRes int resource) {

        GeoJsonSource source = new GeoJsonSource("source");
        mMap.addSource(source);
        Layer layer = new CircleLayer("layer", source.getId());
        mMap.addLayer(layer);

        try {
            source.setGeoJson(Feature.fromJson(ResourceUtils.readRawResource(this, resource)));
        } catch (IOException exception) {
            Timber.e(exception);
        }

        mMap.removeLayer(layer);
        mMap.removeSource(source);

    }

    @Override
    protected void onResume() {
        super.onResume();
        mMapView.onResume();
    }

    @Override
    protected void onStart() {
        super.onStart();
        mMapView.onStart();
    }

    @Override
    protected void onStop() {
        super.onStop();
        mMapView.onStop();
    }

    @Override
    protected void onPause() {
        super.onPause();
        mMapView.onPause();
    }

    @Override
    public void onLowMemory() {
        super.onLowMemory();
        mMapView.onLowMemory();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        mMapView.onDestroy();
    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        mMapView.onSaveInstanceState(outState);
    }


    @Override
    public void onMapClick(@NonNull LatLng point) {
        mVillagesListView.setVisibility(View.GONE);
        final PointF pixel = mMap.getProjection().toScreenLocation(point);
        List<Feature> features = mMap.queryRenderedFeatures(pixel);
        if (mSelectedBuilding != null)
            mSelectedBuilding.remove();
        if (features.size() > 0) {
            Feature feature = features.get(0);

            StringBuilder stringBuilder = new StringBuilder();
            if (feature.getProperties() != null) {
                for (Map.Entry<String, JsonElement> entry : feature.getProperties().entrySet()) {
                    stringBuilder.append(String.format("%s - %s", entry.getKey(), entry.getValue()));
                    stringBuilder.append(System.getProperty("line.separator"));
                }
                Toast.makeText(this,stringBuilder.toString(),Toast.LENGTH_SHORT).show();
            }

            //选中状态
            if (feature.getGeometry() instanceof Polygon) {
                List<LatLng> list = new ArrayList<>();
                for (int i = 0; i < ((Polygon) feature.getGeometry()).getCoordinates().size(); i++) {
                    for (int j = 0; j < ((Polygon) feature.getGeometry()).getCoordinates().get(i).size(); j++) {
                        list.add(new LatLng(
                                ((Polygon) feature.getGeometry()).getCoordinates().get(i).get(j).getLatitude(),
                                ((Polygon) feature.getGeometry()).getCoordinates().get(i).get(j).getLongitude()
                        ));
                    }
                }

                mSelectedBuilding = mMap.addPolygon(new PolygonOptions()
                        .addAll(list)
                        .fillColor(Color.parseColor("#8A8ACB"))
                );
            }
        }
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.btn_switch_map_type:
                if (mMap.getMapType() == MapboxMap.MAP_TYPE_NORMAL) {
                    mMap.setMapType(MapboxMap.MAP_TYPE_SATELLITE);
                } else {
                    mMap.setMapType(MapboxMap.MAP_TYPE_NORMAL);
                }
                break;
            case R.id.btn_query_features:
                queryFeatures("urban-areas-fill",LatLngBounds.from(34,108,33,107));
                break;
        }
    }

    private void queryFeatures(String layerId,LatLngBounds bounds){
        CameraUpdate update = CameraUpdateFactory.newLatLngBounds(bounds,10);
        mMap.animateCamera(update,0);
        GeoJsonSource source = mMap.getSourceAs("urban-areas");
        mSelectFeatures = source.querySourceFeatures(Filter.all());
        mVillagesListView.setVisibility(View.VISIBLE);
        mVillagesListView.setAdapter(new FeatureListAdapter(mSelectFeatures));
        mVillagesListView.setOnItemClickListener(onFeatureItemClickListener);
//        PointF leftTop =  mMap.getProjection().toScreenLocation(new LatLng(85,-179.9));
//        PointF bottomRight =  mMap.getProjection().toScreenLocation(new LatLng(-85,179.9));
//        List<Feature> features =  mMap.queryRenderedFeatures(new RectF(leftTop.x,leftTop.y,bottomRight.x,bottomRight.y),layerId);

    }


    class FeatureListAdapter extends BaseAdapter{
        private List<Feature> mListFeature;
        public FeatureListAdapter(List<Feature> list){
            this.mListFeature = list;
        }
        @Override
        public int getCount() {
            return mListFeature.size();
        }

        @Override
        public Object getItem(int position) {
            return mListFeature.get(position);
        }

        @Override
        public long getItemId(int position) {
            return 0;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            TextView textView = new TextView(parent.getContext());
            AbsListView.LayoutParams params = new AbsListView.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 96);
            textView.setLayoutParams(params);
            textView.setText(""+position);
            textView.setClickable(false);
            return textView;
        }
    }

    private AdapterView.OnItemClickListener onFeatureItemClickListener = new AdapterView.OnItemClickListener() {
        @Override
        public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
            if (mSelectedBuilding != null)
                mSelectedBuilding.remove();
            Feature feature = mSelectFeatures.get(position);
            List<LatLng> list = new ArrayList<>();
            for (int i = 0; i < ((Polygon) feature.getGeometry()).getCoordinates().size(); i++) {
                for (int j = 0; j < ((Polygon) feature.getGeometry()).getCoordinates().get(i).size(); j++) {
                    list.add(new LatLng(
                            ((Polygon) feature.getGeometry()).getCoordinates().get(i).get(j).getLatitude(),
                            ((Polygon) feature.getGeometry()).getCoordinates().get(i).get(j).getLongitude()
                    ));
                }
            }
//            mSelectedBuilding = mMap.addPolygon(new PolygonOptions()
//                    .addAll(list)
//                    .fillColor(Color.parseColor("#8A8ACB"))
//            );
            LatLngBounds bounds = LatLngBounds.fromLatLngs(list);
            CameraUpdate update = CameraUpdateFactory.newLatLngBounds(bounds,10);
            mMap.animateCamera(update);
        }
    };


}
