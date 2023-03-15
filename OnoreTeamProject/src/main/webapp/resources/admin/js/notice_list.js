$('#notice-delete-btn').click(function() {
    if ($("input:checkbox[name=row_check]:checked").length == 0) {
        alert('삭제할 항목을 선택해주세요.');
    } else {
        var result = confirm('삭제하시겠습니까?');

        if(result) {
            var formData = $('#notice-list-form').serialize();
            
            var checked = $("input:checkbox[name=row_check]:checked").length;
            $.ajax({
                url: contextPath + "/admin/notice/delete",
                type: "POST",
                cache: false,
                data: formData,
                cache : false,
                success: function(data){
                    alert(checked + "개의 공지사항을 삭제하였습니다.");
                    movePageByGet(contextPath + '/admin/notice/list');
                },
                error: function (request, status, error){        
                    console.log(error);
                }
            })     
        } else {
            
        }
    }
});

$('#search-btn').click(function() {
    var search_type = $('select[name=search_type]').val();
    var search_keyword = $('input[name=search_keyword]').val();

    if (search_keyword == '') {
        alert('검색어를 입력해주세요.');
    } else {
        movePageByGet(contextPath + "/admin/notice/list?search_type=" + search_type + "&search_keyword=" + search_keyword);
    }
});

$('input[name=search_keyword]').click(function() {
    $('input[name=search_keyword]').val('');
});

$('input[name=search_keyword]').keydown(function (key) {
    // 엔터키 누르면 검색 (엔터키의 키코드 13)
    if(key.keyCode == 13) {
        var search_type = $('select[name=search_type]').val();
        var search_keyword = $('input[name=search_keyword]').val();
        movePageByGet(contextPath + "/admin/notice/list?search_type=" + search_type + "&search_keyword=" + search_keyword);
    }
});
