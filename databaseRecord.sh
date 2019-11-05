# !/bin/bash 数据库数据备份

DB_NAME=    # 数据库用户名
DB_PWD=	    # 数据库密码
DATABASES=()	# 需要备份的数据库名（数组类型）

DAYS=2
DUMP=/usr/bin/mysqldump
DATE=`date +%Y-%m-%d`
DIR="mysql-$DATE"

if [ ! -d "$DIR" ]
then
        mkdir $DIR
fi

chmod 755 $DIR
cd $DIR

# 循环备份各个数据库
for i in ${DATABASES[@]}
do
        echo $i
        RAW="$i.sql"
        TAR="$i.tar.gz"
        $DUMP -u$DB_NAME -p$DB_PWD $i > $RAW
        tar -czvf $TAR $RAW
        rm $RAW
done

# 删除2天之前的备份目录及文件 
find /root -name "mysql-*" -mtime +$DAYS | xargs rm -rf
