console.log("reply");

var replyService = (function(){

    function add(reply, callback, error) {
        console.log("add reply");

        $.ajax({
            type : 'post',
            url : '/reply/new',
            data : JSON.stringify(reply),
            contentType : "application/json; charset=utf-8",
            success : function(result, status, xhr) {

                if (callback) {
                    callback(result);
                }
            },
            error : function(xhr, status, er) {
                if (error) {
                    error(er);
                }
            }
        });
    }

    function getList(param, callback, error) {

        var boardNum = param.boardNum;
        
        var page = param.page || 1;

        $.getJSON("/reply/pages/" + boardNum + "/" + page + ".json", function(data){

            if (callback) {
                callback(data.replyCnt, data.list);
            }
        }).fail(function(xhr, status, err) {

            if (error) {
                error();
            }
    	});
    }

    function remove(replyNum, callback, error) {

        $.ajax({
            type:'delete',
            url:'/reply/' + replyNum,
            success:function(deleteResult, status, xhr) {

                if (callback) {
                    callback(deleteResult);
                }
            },
            error:function(xhr, status, er) {

                if (error) {
                    error(er);
                }
            }
        });
    }

    function update(reply, callback, error) {

        console.log("replyNum : " + reply.replyNum);

        $.ajax({
            type:'put',
            url:'/reply/' + reply.replyNum,
            data:JSON.stringify(reply),
            contentType:"application/json; charset=utf-8",
            success:function(result, status, xhr) {

                if (callback) {
                    callback(result);
                }
            },
            error:function(xhr, status, er) {

                if (error) {
                    error(er);
                }
            }
        });
    }

    function get(replyNum, callback, error) {

        $.get("/reply/" + replyNum + ".json", function(result) {

            if (callback) {
                callback(result);
            }
        }).fail(function(xhr, status, err) {

            if (error) {
                error();
            }
        });
    }

    function displayTime(timeValue) {
        var today = new Date();
        
        var gap = today.getTime() - timeValue;
        
        var dateObj = new Date(timeValue);
        var str = "";
        
        if (gap < (1000 * 60 * 60 * 24)) {
           var hh = dateObj.getHours();
           var mi = dateObj.getMinutes();
           var ss = dateObj.getSeconds();
           
           return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss ].join('');
        } else {
           var yy = dateObj.getFullYear();
           var mm = dateObj.getMonth() + 1;
           var dd = dateObj.getDate();
           
           return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd ].join('');
        }
    }

    return {
        add:add,
        getList:getList,
        remove:remove,
        update:update,
        get:get,
        displayTime:displayTime

    };
})();