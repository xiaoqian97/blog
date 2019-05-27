
$(function () {
        var txt = "<span class='txt'></span>";
        $('body').append(txt);
        var txted = $(".txt");
        txted.css({
            position: "absolute",
            color: "red",
        });
        var Animated = function (x) {
            x.stop().animate({
                top: "-=80px",
                opacity: '1'
            }, 1000, function () {
                $(this).animate({
                    opacity: "0"
                }, 1000);
            });
        };
        $(document).on("click", function (e) {
            var attr = ["富强、民主", "文明、和谐", "文明、和谐", "公正、法治", "爱国、敬业", "诚信、友善", "如果你想得到艺术的享受，那你就必须是一个有艺术修养的人。",
            "我要让这天再也遮不住我的眼 让这地再也葬不了我的心","生我何用，不能欢笑。灭我何用，不减狂骄。 "];
            var mathText = attr[Math.floor(Math.random() * attr.length)];
            //获取鼠标的位置
            var x = e.pageX - 32 + "px";
            var y = e.pageY - 18 + "px";
            txted.text(mathText);
            txted.css({
                "left": x,
                "top": y
            });
            Animated(txted);
        });
    });
   text = "小千哥哥";
			i    = 0;
			function flash(){
				str = text.charAt(i);
				str = "<b>" + str + "</b>";
				leftStr  = text.substr(0,i);
				rightStr = text.substr(i+1,text.length-i);
				txt.innerHTML = leftStr + str + rightStr;
				i++;
				if (i>=text.length)i=0;
				setTimeout("flash()",500);
			}