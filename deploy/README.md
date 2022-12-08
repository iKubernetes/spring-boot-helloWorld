# spring boot hellworld 示例配置

### 配置文件说明

两组配置，可独立使用;

第一组：使用了专用的名称空间
- 01-namespace.yaml  
- 02-service.yaml  
- 03-deployment.yaml

第二组：没有明确定义名称空间
- all-in-one.yaml


**注意**：无论哪组配置，deployment资源中的pod template中，默认运行的容器的Image都需要修改后才能使用。


