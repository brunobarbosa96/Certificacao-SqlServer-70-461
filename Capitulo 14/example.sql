SELECT cpu_count AS logical_cpu_count,
cpu_count / hyperthread_ratio AS physical_cpu_count,
CAST(physical_memory_kb / 1024. AS int) AS physical_memory__mb,
sqlserver_start_time
FROM sys.dm_os_sys_info;