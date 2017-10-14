# live（直播项目）
#### 技术要点
* 首页多个栏目的控制器放在CollectionView上，可左右滚动可切换控制器，标题栏是单独封装的控件，通过代理与外界进行交互。
* 瀑布流使用常规方式创建：自定义UICollectionViewFlowLayout，定义数据源方法获取item高度和列数，在prepare方法中计算出每个item的frame，重写-layoutAttributesForElements方法和-collectionViewContentSize方法，返回对应数据即可。
* 采用MVVM模式，View中的数据绑定ViewModel，在Controller（View）中调用ViewModel进行网络请求，请求完毕刷新View。
