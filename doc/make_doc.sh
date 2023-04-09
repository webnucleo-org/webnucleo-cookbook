mkdir -p source/_static source/_templates
sphinx-apidoc -M -f -o source ../webnucleo-cookbooks
make html
