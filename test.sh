#LVM_status=$()
if systemctl --quiet is-active lvm2-lvmetad.service; then
    LVM_status="yes";
else
    LVM_status="no";
fi
echo $LVM_status
