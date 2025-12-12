import logging
import typing as t

from apolo_app_types.outputs.base import BaseAppOutputsProcessor
from apolo_apps_spark_job.types import SparkJobOutputs


logger = logging.getLogger()


async def get_spark_job_outputs(
    helm_values: dict[str, t.Any],
    app_instance_id: str,
) -> SparkJobOutputs:
    return SparkJobOutputs()


class SparkJobOutputProcessor(BaseAppOutputsProcessor[SparkJobOutputs]):
    async def _generate_outputs(
        self,
        helm_values: dict[str, t.Any],
        app_instance_id: str,
    ) -> SparkJobOutputs:
        return await get_spark_job_outputs(helm_values, app_instance_id)
