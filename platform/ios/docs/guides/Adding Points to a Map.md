# 在地图上添加点

GeoMap提供多种注记的方式

## GCLPointAnnotation

最简单的是在地图上直接添加一个注记

```swift
let annotation = GCLPointAnnotation()
annotation.coordinate = CLLocationCoordinate2D(latitude: 45.5076, longitude: -122.6736)
annotation.title = "Bobby's Coffee"
annotation.subtitle = "Coffeeshop"
mapView.addAnnotation(annotation)
```

更详细的注记交互防范，参见 `GCLMapViewDelegate` 的`-mapView:annotationCanShowCallout:` 和其它类似方法.

## 注记的展示方式

GeoMap提供了两种注记的展示方式，用户可以根据需求自由选择.

### 图片注记 (`GCLAnnotationImage`)

图片是最基本也是最快速的注记展示方式.

GeoMap默认会提供了一个红色的图片来展示注记. 用户如果需要显示自定义图片，需要使用 `GCLMapViewDelegate` `-mapView:imageForAnnotation:` 方法.

**优势**

* 使用最简单
* 使用`UIImage`可以简单快速的定制图片
* 高性能, 图片直接使用OpenGL渲染

**劣势**

* 图片只能是静态的，不能使用动图
* 不能控制控制图片的Z轴方向的顺序

### 视图注记 (`GCLAnnotationView`)

加入你期望在地图上显示一个动态的视图和图片, 建议使用 `GCLAnnotationView`.

如果你希望每个注记都不一样，那么视图注记再合适不过了. 例如在地图上展示当前位置.

要使用视图注记 请使用 `MGLMapViewDelegate` `-mapView:viewForAnnotation`.

**优势**

* 可定制，原生视图
* 没有类型和图片大小的限制
* 支持动画
* 可以使用 `CALayer`的 `zPosition`属性控制Z轴的顺序

**劣势**

* 性能影响:
    * 相对于OpenGL渲染图片，`UIView` 的绘制更慢, 特别是在添加了大量视图和地图移动频繁的情况下。
    * 在某写情况下，建议使用动态样式

## 高级: 动态样式

如果想要完全的控制地图上添加的点，请考虑使用 [runtime styling](runtime-styling.html).

你可以用使用 `GCLPointFeature` 或者其它 [style primitives](Style%20Primitives.html) 将点或者其它图形添加到 `GCLShapeSource`.

你可以用创建 `GCLSymbolStyleLayer` 或者 `GCLCircleStyleLayer` 图层来添加点.

**优势**

* 最优的选择
* 性能优越
* SDK中支持对点样式的定制
* 可以通过调整图层的上下顺序控制点在Z轴的顺序

**劣势**

* 现在，必须通过自己检测Tap手势来实现 `GCLMapView.visibleFeaturesAtPoint` 与点的交互.
* 目前的SDK还不支持动画.
