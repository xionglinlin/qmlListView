# qmlListView

提供了如下三种 model 类型给 ListView 使用

```
enum ModelType {
    UseInt = 1,
    UseListModel,
    UseQAbstractListModel
}
```

可以通过 modelType 变量来切换 model 类型