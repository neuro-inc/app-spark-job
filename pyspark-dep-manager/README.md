# Using additional dependencies in PySpark Jobs

After some tests with virtualenv, venv, conda and pex following PySpark's [documentation](https://spark.apache.org/docs/latest/api/python/user_guide/python_packaging.html#using-pex) on Python package management, I concluded that the best way to do it (ie the only one that worked) is using Pex and generating a file that can be mounted into our Spark driver and workers.

Use the Docker image created for this:

```bash
docker build -t gen-pyspark-deps ./dependency-management
# you always need to pass the pyspark dependency. If you use this method, the environment does not have any extra packages
docker run --rm -v ./deps:/mnt/export gen-pyspark-deps pyspark <pypi-libs>
```
