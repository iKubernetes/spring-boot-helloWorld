# Rollout 示例配置

示例中共创建了三个资源：
- service
- deployment
- ingress：依赖于Ingress Nginx

其中，deployment中的pod template上没有为默认的容器设定镜像，在使用时需要将其中的“\__IMAGE__”替换为具体的镜像文件； 