# !/bin/bash ���ݿ����ݱ���

DB_NAME=    # ���ݿ��û���
DB_PWD=	    # ���ݿ�����
DATABASES=()	# ��Ҫ���ݵ����ݿ������������ͣ�

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

# ѭ�����ݸ������ݿ�
for i in ${DATABASES[@]}
do
        echo $i
        RAW="$i.sql"
        TAR="$i.tar.gz"
        $DUMP -u$DB_NAME -p$DB_PWD $i > $RAW
        tar -czvf $TAR $RAW
        rm $RAW
done

# ɾ��2��֮ǰ�ı���Ŀ¼���ļ� 
find /root -name "mysql-*" -mtime +$DAYS | xargs rm -rf
