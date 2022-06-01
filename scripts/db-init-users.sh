#!/bin/bash

touch db-users-insert.sql
echo 'TRUNCATE users;' > db-users-insert.sql

for ((i = 1; i < 1001; i++)); do
	
	COUNTER=$(printf "%04d" ${i})
	ACTIVE=yes
	DELETED=NULL

	DATE1="2021-01-10 10:44:07"
	DATE2="2021-04-10 02:44:07"
	DATE3="2021-08-10 01:44:07"
	DATE4="2021-02-10 12:44:07"
	DATE5="2021-06-10 13:44:07"
	DATE6="2021-11-10 16:44:07"
	DATE7="2021-09-10 01:44:07"
	DATE8="2021-10-10 09:44:07"
	DATE9="2021-02-10 06:44:07"

	DATE10="2022-02-10 09:44:07"
	DATE11="2022-04-10 22:44:07"
	DATE12="2022-05-10 12:44:07"
	DATE13="2022-02-10 15:44:07"
	DATE14="2022-03-10 13:44:07"
	DATE15="2022-01-10 17:44:07"
	DATE16="2022-04-10 18:44:07"
	DATE17="2022-02-10 20:44:07"
	DATE18="2022-05-10 15:44:07"

	if [[ ${i} < 10 ]]; then
		DATE=${DATE1}
	elif [[ ${i} < 50 ]]; then
		DATE=${DATE2}
	elif [[ ${i} < 100 ]]; then
		DATE=${DATE3}
		ACTIVE=no
	elif [[ ${i} < 150 ]]; then
		DATE=${DATE2}
	elif [[ ${i} < 200 ]]; then
		DATE=${DATE4}
		DELETED="'${DATE4}'"
		ACTIVE=no
	elif [[ ${i} < 250 ]]; then
		DATE=${DATE5}
	elif [[ ${i} < 300 ]]; then
		DATE=${DATE6}
	elif [[ ${i} < 350 ]]; then
		DATE=${DATE7}
	elif [[ ${i} < 400 ]]; then
		DATE=${DATE8}
	elif [[ ${i} < 450 ]]; then
		DATE=${DATE9}
		DELETED="'${DATE9}'"
		ACTIVE=no
	elif [[ ${i} < 500 ]]; then
		DATE=${DATE10}
	elif [[ ${i} < 550 ]]; then
		DATE=${DATE11}
	elif [[ ${i} < 600 ]]; then
		DATE=${DATE12}
	elif [[ ${i} < 650 ]]; then
		DATE=${DATE13}
	elif [[ ${i} < 700 ]]; then
		DATE=${DATE14}
		ACTIVE=no
	elif [[ ${i} < 750 ]]; then
		DATE=${DATE15}
	elif [[ ${i} < 800 ]]; then
		DATE=${DATE16}
	elif [[ ${i} < 850 ]]; then
		DATE=${DATE17}
		DELETED="'${DATE17}'"
		ACTIVE=no
	elif [[ ${i} < 900 ]]; then
		DATE=${DATE18}
	else
		DATE=$(date '+%Y-%m-%d %H:%M:%S')
	fi

	echo "INSERT INTO \`users\`(name, doc, address, active, createdAt, updatedAt, deletedAt)
	VALUES('Firstname Lastname ${COUNTER}', '1234560010${COUNTER}', 'Address User Sample ${COUNTER}', '${ACTIVE}', '${DATE}', NULL, ${DELETED});" >> db-users-insert.sql
	echo "" >> db-users-insert.sql

done

exit 0
