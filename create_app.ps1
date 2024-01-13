$name = "\new_application"
$path = ".\lib\apps" + $name
New-Item -ItemType Directory -Path ($path + "\data")
New-Item -ItemType Directory -Path ($path + "\data\service")
New-Item -ItemType Directory -Path ($path + "\data\service\local")
New-Item -ItemType Directory -Path ($path + "\data\service\remote")
New-Item -ItemType Directory -Path ($path + "\data\repository")
New-Item -ItemType Directory -Path ($path + "\domain")
New-Item -ItemType Directory -Path ($path + "\domain\model")
New-Item -ItemType Directory -Path ($path + "\domain\repository")
New-Item -ItemType Directory -Path ($path + "\presentation")
New-Item -ItemType Directory -Path ($path + "\presentation\controller")
New-Item -ItemType Directory -Path ($path + "\presentation\widgets")
New-Item -ItemType Directory -Path ($path + "\presentation\pages")