//此check()函式在最後的「傳送」案鈕會用到
function check()
{
    //若<form>屬性name值為reg裡的文字方塊值為空字串，則顯示「未輸入姓名」
    if(reg.key.value == "")
    {
        alert("未輸入代碼");
    }
//    //若<form>屬性name值為reg裡的文字方塊與下拉式選單值為空字串或是沒有選擇月或日，則顯示「未輸入完整生日日期」
//    else if(reg.year.value == "" || reg.month.value == "00" || reg.day.value == "00")
//    {
//        alert("未輸入完整生日日期");
//    }
//    //若<form>屬性name值為reg裡的核取方塊沒有選擇，則顯示「未選擇性別」
//    else if(!reg.sex[0].checked && !reg.sex[1].checked)
//    {
//        alert("未選擇性別");
//    }
//    //若以上條件皆不符合，也就是表單資料皆有填寫的話，則將資料送出
    else reg.submit();
}
