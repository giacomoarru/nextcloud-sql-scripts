# Tested on Nextcloud 22
SET @username = 'username'; # set username here
SELECT 
    u.uid,
    f.fileid,
    f.path,
    f.name,
    f.size,
    FROM_UNIXTIME(f.mtime)
FROM
    nextcloud.oc_filecache f,
    nextcloud.oc_storages s,
    nextcloud.oc_users u
WHERE
    u.uid = @username
        AND s.id = CONCAT('object::user:', u.uid)
        AND f.storage = s.numeric_id
        AND s.available = 1
        AND f.mimetype != 2
        AND path NOT IN ('cache' , 'files', '')
        AND path NOT LIKE 'files_trashbin%'
        AND size > 0
ORDER BY path ASC
