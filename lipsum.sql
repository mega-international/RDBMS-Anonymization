
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE FUNCTION lipsum(  @Input VARCHAR(max), @language int)
    RETURNS NVARCHAR(max)

    BEGIN    

	DECLARE @v_text_lipsum NVARCHAR(2500);

	SET @v_text_lipsum =   
        CASE   @language
           
            WHEN 1033   THEN 'a ac accumsan ad adipiscing aenean aliquam aliquet amet ante aptent arcu at auctor augue bibendum blandit class commodo condimentum congue consectetuer consequat conubia convallis cras cubilia cum curabitur curae; cursus dapibus diam dictum dignissim dis dolor donec dui duis egestas eget eleifend elementum elit enim erat eros est et etiam eu euismod facilisi facilisis fames faucibus felis fermentum feugiat fringilla fusce gravida habitant hendrerit hymenaeos iaculis id imperdiet in inceptos integer interdum ipsum justo lacinia lacus laoreet lectus leo libero ligula litora lobortis lorem luctus maecenas magna magnis malesuada massa mattis mauris metus mi molestie mollis montes morbi mus nam nascetur natoque nec neque netus nibh nisi nisl non nonummy nostra nulla nullam nunc odio orci ornare parturient pede pellentesque penatibus per pharetra phasellus placerat porta porttitor posuere praesent pretium primis proin pulvinar purus quam quis quisque rhoncus ridiculus risus rutrum sagittis sapien scelerisque sed sem semper senectus sit sociis sociosqu sodales sollicitudin suscipit suspendisse taciti tellus tempor tempus tincidunt torquent tortor tristique turpis ullamcorper ultrices ultricies urna ut varius vehicula vel velit venenatis vestibulum vitae vivamus viverra volutpat vulputate'
			--russian
			WHEN 1049 THEN N'ты что он было к нет слово но какие некоторые мы жестяная банка из Другие мы все там когда вверх использовать ваш как сказал ан каждый она который делать их время если буду способ о много тогда их записывать бы нравиться так эти ее длинный делать вещь чем вызов первый кто мая вниз боковая сторона был Теперь найти любой новый Работа часть брать получать место сделал жить куда после назад маленький Только круглый человек год пришел Показать каждый хороший меня давать низкий линия отличаться перемена причина много иметь в виду до двигаться Правильно мальчик Старый тоже тем же рассказать делает установленный три хотеть воздух хорошо также играть небольшой конец положил дом читать рука порт большой заклинание Добавить выше Когда-либо красный список хотя Чувствовать разговаривать птица скоро тело собака семья непосредственный поза оставлять песня мера дверь продукт чернить короткая цифра класс ветер вопрос случаться полный корабль площадь половина рок порядок Огонь юг проблема Лучший час лучше правда в течение сотня пять помнить шаг рано держать Запад земля интерес достигать быстро глагол петь Слушать шесть стол путешествовать меньше утро 10 просто несколько гласный звук к война класть против шаблон медленный центр любовь человек Деньги обслуживать появляться Дорога карта дождь правило управлять тянуть холодно уведомление голос Ед'
			--Hebrew
			WHEN 1037 THEN N'פועל שר האזינו שש שולחן נסיעה פחות בוקר 10 רק כמה קולות למלחמה מונחים נגד תבנית איטית מרכז אהבה אדם כסף מגישים מפת דרך משטר גשם מנהלתאלה היא עושה את הדבר הארוך שלה מאשר לאתגר את הראשון שעשוי להיות בצד היה עכשיו למצוא כל תפקיד חדש לקחת לקחת את המקום עשה חיים שבו אחרי בחזרה קטן רק כל השנה הגיע גבר הצג כל טוב לי לתת קו נמוך להיות שונה שינוי לגרום הרבה לזכור לפני המעבר ילד ימין גם זקן אותו מספר האם להגדיר שלוש רוצה אוויר טוב גם לשחק קטן לשים הבית לקרוא יד יציאה גדולה כישוף הוסף גבוה יותר אי פעםמאחורי זנב טהור לייצר אובייקט כחוללמשוך יחידה קולית להודעות קרותלמשוך יחידה קולית להודעות קרות ism power city מוגדר בצורה מושלמת לעוף טיפה עופרת לבכות כהה רכב פתק לחכות מתאר צורת תיבת שם עצ מוגדר בצורה מושלמת לעוף טיפה עופרת לבכות כהה רכב פתק לחכות מתאר צורת תיבת שם עצם כוכב מלא לפתור משטח אי ירח עמוק מערכת רגליים עסוק בדיקת משימות שיא סירה סה"כ מטוס אפשרי במקום צחוק פלא יבש רכב פתק לחכות מתאר צורת תיבת שם עצ מוגדר בצורה מושלמת לעוף טיפה עופרת לבכות כהה רכב פתק לחכות מתאר צורת תיבת שם עצם כוכב מלא לפתור משטח אי ירח עמוק מערכת רגליים עסוק בדיקת משימות שיא סירה סה"כ מטוס אפשרי  רכב פתק לחכות מתאר צורת תיבת שם עצ מוגדר בצורה מושלמת לעוף טיפה עופרת לבכות כהה רכב פתק לחכות מתאר צורת תיבת שם עצם כוכב מלא לפתור משטח אי ירח עמוק מערכת רגליים עסוק בדיקת משימות שיא סירה סה"כ מטוס אפשרי '
			--Thai
			WHEN 1054 THEN N'แสดงแผนที่ถนนกฎฝ นจัดการดึงเสียงแจ้งเตือ นเย็นเอ็ดอำนาจ เมือง กำหนดอย่างสมบูรณ์แบบ บิน ปล่อย ตะกั่ว ร้องไห้ มืด รถ บันทึก รอ แผน รูป ดาว กล่อง คำนาม ฟิลด์ ส่วนที่เหลือ จริง สามารถ ปอนด์ ทำ ความงาม ขับรถ ยืน หน้า สอน สัปดาห์สุดท้าย ให้ สีเขียว โอ้ รวดเร็ว พัฒนา มหาสมุทร ความร้อน ฟรี นาที เข้มแข็ง พิเศษ จิตใจ เบื้องหลัง หางบริสุทธิ์ ผลิต เต็มกำลัง สีน้ำเงิน วัตถุ แก้โจทย์ พื้นผิว ลึก ดวงจันทร์ เกาะ เท้า ระบบ ไม่ว่าง ทดสอบ งาน บันทึก เรือ รวม ทอง เป็นไปได้ เครื่องบิน แทนที่จะเป็น แห้ง สงสัย หัวเราะ ต้นแอปเปิ้ล มะนาว คำ ทำไม อิจฉา นานที่สุด โลก สิ่งของ อาจจะ ความรู้ ซ้ำ เหลือเชื่อ ความสามารถ ทักษะ ออกกำลังกาย กีฬา สีน้ำเงิน สีแดง ไม่มีใคร น่าสงสัย ไม่เป็นไร ผิด คน สิ่ง ธรรมดา เรือ รถยนต์ รถโดยสารประจำทาง ค่ามัธยฐาน ค่าเฉลี่ย ไม่เคยเสมอ วันจันทร์ ตอนนี้ ปลายฤดูใบไม้ผลิ แต่เธอขอโทษ ที่ยึดครอง มากกว่า เสียทะเล ภาคภูมิใจ ดีที่สุด นานาชาติ ฉลาม หวังว่า อาทิตย์ เกษียณ วันหยุด ไปพบแพทย์ วิศวกร เกือบจะเสร็จสิ้น ต้องเพิ่มประโยค ถึงเพียงพอ คำนวณ คอมพิวเตอร์ การจ่ายเงิน เกลียดบทสรุปนี้ พัน พาสต้าสีเหลือง ขนมปัง กิน เครื่  ขับรถ ยืน หน้า สอน สัปดาห์สุดท้าย ให้ สีเขียว โอ้ รวดเร็ว พัฒนา มหาสมุทร ความร้อน ฟรี นาที เข้มแข็ง พิเศษ จิตใจ เบื้องหลัง หางบริสุทธิ์ ผลิต เต็มกำลัง สีน้ำเงิน วัตถุ องดื่ม ความโศกเศร้า น้ำใส แต่ไฟ เจ้านาย จักรวรรดิวิ่งทางการแพทย์ การหย่าร้าง เรื่องอื้อฉาว ราชินีตำหนิ เย็น ตะกั่ว พัฒนา' 
			--viet
			WHEN 1066 THEN N'Phục vụ Xuất hiện Bản đồ đường đi Quy tắc mưa Quản lý Kéo lạnh Thông báo bằng giọng nói Ed định nghĩa hoàn hảo bay thả chì khóc tối xe lưu ý chờ kế hoạch hình ngôi sao hộp danh từ trường phần còn lại đúng có thể pound thực hiện vẻ đẹp lái xe đứng giữ phía trước dạy tuần cuối cùng cho màu xanh lá cây oh nhanh chóng phát triển nhiệt đại dương phút mạnh mẽ đặc biệt sau đuôi tinh khiết sản xuất toàn bộ sức mạnh vật màu xanh giải bề mặt sâu mặt trăng đảo chân hệ thống bận thi nhiệm vụ kỷ lục thuyền tổng số vàng có thể máy bay thay khô thắc mắc cười cây táo chanh từ tại sao ghen tị lâu nhất thứ quả đất có thể kiến ​​thức nhân bản kỹ năng tài năng lạ thường thể thao màu xanh đỏ không ai nghi ngờ được rồi sai người điều bình thường tàu xe trung tuyến có nghĩa là không bao giờ luôn là thứ hai bây giờ cuối xuân nhưng cô xin lỗi đi chinh phục lớn hơn mất biển tự hào nhất quốc tế cá mập hy vọng chủ nhật nghỉ hưu thăm bác sĩ kỹ sư gần xong phải thêm câu đạt đủ tính toán thanh toán máy tính ghét kết luận này nghìn bánh mì mì vàng ăn uống nỗi buồn nước trong tuy nhiên lửa trùm y tế đế chế chạy nước rút xây dựng nhà nước ly hôn scandale nữ hoàng chỉ trích Quy tắc mưa Quản lý Kéo lạnh Thông báo bằng giọng khóc tối xe lưu ý chờ kế hoạch hình ngôi sao hộp danh từ trường phần còn lại đúng có thể pound thực hiện vẻ đẹp'
			--Greek
			WHEN 1032 THEN N'Ισμή δύναμης πόλη τέλεια καθορισμένη μύγα μολύβδου κλαίει σκοτεινό αυτοκίνητο σημειώστε σχέδιο σχήμα αστέρι κουτί ουσιαστικό πεδίο αληθινή ικανή λίρα τελείωσε ομορφιά οδήγησε κρατήστε μπροστά διδάξτε την εβδομάδα τελικό έδωσε πράσινο ω γρήγορα αναπτύξτε ωκεανό ζέστη ελεύθερο λεπτό δυνατό ειδικό μυαλό πίσω από καθαρή ουρά παράγουν πλήρη δύναμη μπλε αντικείμενο λύσει επιφάνεια βαθιά φεγγάρι νησίδα πόδι σύστημα απασχολημένος δοκιμαστική εγγραφή σκάφος συνολικό χρυσό πιθανό αεροπλάνο αντί για ξηρό θαύμα γέλιο μηλιά λεμόνι λέξη γιατί ζηλεύω μακρύτερα πράγματα γης ίσως γνώση διπλότυπο απίστευτη ταλαντούχα δεξιότητα άσκηση μπλε κόκκινο κανείς κανένας καχύποπτος εντάξει λάθος άνθρωποι πράγματα συνηθισμένα πλοίο αυτοκίνητο λεωφορείο μέσος όρος ποτέ πάντα Δευτέρα τώρα αργότερα άνοιξη, αλλά λυπάμαι που παίρνει τεράστια κατάκτηση από τη χαμένη θάλασσα υπερήφανος καλύτερος διεθνής καρχαρίας ελπίζουμε Κυριακή συνταξιούχοι διακοπές επισκεφθείτε γιατρό μηχανικός σχεδόν τελειώσει πρέπει να προσθέσει προτάσεις φτάσει αρκετά υπολογισμός πληρωμής μίσος αυτό το συμπέρασμα χιλιάδες κίτρινα ζυμαρικά ψωμί τρώγοντας ποτό θλίψη καθαρό νερό ωστόσο fire boss boss ιατρική σπριντ αυτοκρατορία κρατική οικοδόμηση σκάνδαλο βασίλισσα μομφή Ισμή δύναμης πόλη τέλεια καθορισμένη μύγα μολύβδου κλαίει σκοτεινό αυτοκίνητο σημειώστε σχέδιο'
			--Korean
			WHEN 1042 THEN N'서브 등장 로드맵 비 규칙 관리 풀 콜드 알림 보이스 에드힘 도시 완벽하게 정의된 파리 드롭 리드 외침 어두운 차 메모 기다림 계획 그림 별 상자 명사 들판 휴식 참을 수 있는 파운드 완료 아름다움 드라이브 서 있던 앞 가르치다 주 결승전 준 녹색 오 빨리 발전 바다 열이 없는 분 강한 특별한 마음 뒤에 순수한 꼬리 생성 완전한 힘 파란색 물체 풀다 표면 깊은 달 섬 발 시스템 바쁘다 테스트 작업 기록 보트 총 금 가능 비행기 대신 건조 경이 웃음 사과 나무 레몬 단어 왜 부러워요 가장 길다 지구 물건 아마도 지식 복제 믿을 수 없는 재능 기술 운동 스포츠 블루 빨강 아무도 의심스럽다 옳지 않다 사람 물건 평범하다 배 차 버스 중위수 평균 안 항상 월요일 지금은 늦봄 그러나 그녀는 미안하다 거대 정복하다 잃어버린 바다보다 자랑스럽다 최고 국제 상어 희망적 일요일 은퇴한 휴일 방문 의사 엔지니어 거의 끝마쳐야 문장을 추가해야 한다 충분히 계산하다 계산 컴퓨터 지불 이 결론을 싫어한다 천 노란색 파스타 빵 먹기 음료수 비애 맑은 물 그러나 불 보스 의료 스프린트 제국 스테이트 빌딩 이혼 스캔데일 여왕 비난 서브 등장 로드맵 비 규칙 관리 풀 콜드 알림 보이스 에드힘 도시 완벽하게 정의된 파리 드롭 리드 외침 어두운 차 메모 기다림 계획 그림 별 상자 명사 들판 휴식 참을 수 있는 파운드 완료 아름다움 드라이브 서 있던 앞 가르치다 주 결승전 준 녹색 오 빨리 발전 바다 열이 없는 분 강한 특별한 마음 뒤에 순수한 꼬리 생성 완전한 힘 파란색 물체 풀다 표면 깊은 달 섬 발 시스템 바쁘다 테스트 작업 기록 보트 총 금 가능 비행기 대신 건조 경이 웃음 사과 나무 레몬 단어 왜 부러워요 가장 길다 지구 물건 아마도 지식 복제 믿을 수 없는 재능 기술 운동 스포츠 블루 빨강 아무도 의심스럽다 옳지 않다 사람 물건 평범하다 배 차 버스 중위수 평균 안 항상 월요일 지금은 늦봄 그러나 그녀는 미안하다 거대 정복하다 잃어버린 바다보다 자랑스럽다 최고 국제 상어 희망적 일요일 은퇴한 휴일 방문 의사 엔지니어 거의 끝마쳐야 문장을 추가해야 한다 충분히 계산하다 계산 컴퓨터 지불 이 결론을 싫어한다 천 노란색 파스타 빵 먹기 음료수 비애 맑은 물 그러나 불 보스 의료 스프린트 제국 스테이트 빌딩 이혼 스캔데일 여왕 비난 서브 등장 로드맵 비 규칙 관리 풀 콜드 알림 보이스 에드힘 도시 완벽하게 정의된 파리 드롭 리드 외침 어두운 차 메모 기다림 계획 그림 별 상자 명사 들판 휴식 참을 수 있는 파운드 완료 아름다움 드라이브 서 있던 앞 가르치다 주 결승전 준 녹색 오 빨리 발전 바다 열이 없는 분 강한 특별한 마음 뒤에 순수한 꼬리 생성 완전한 힘 파란색 물체 풀다 표면 깊은 달 섬 발'
			--Japanese
			WHEN 1041 THEN N'サーブアピアロードマップレインルール管理プルコールド通知音声エド。完全に定義されたフライドロップリードクライダークカーノート待機計画図スターボックス名詞フィールドレスト真の可能ポンド完了ビューティードライブスタンドキープフロントティーチウィークファイナルギブグリーンオーファスト開発オーシャンヒートフリーミニッツストロングスペシャルマインドピュアテールの背後にあるフルストレングスブルーオブジェクトソルブ表面の深い月の島の足システム忙しいテストタスクレコードボートドライワンダーの代わりに可能な平面合計金笑うリンゴの木レモンの言葉なぜ羨望の長い地球のもの多分知識重複信じられないほどの才能のあるスキルエクササイズスポーツ青赤誰も疑わしい大丈夫間違った人々のもの普通の船の車のバス中央値は常に月曜日が春の終わりになることはありませんが、彼女は失われた海よりも大きな征服をして申し訳ありません最高の国際的なサメ希望に満ちた日曜日の引退した休日訪問医師エンジニアほぼ終了文を追加する必要がありますしかし、火のボスの医療スプリント帝国の州の建物離婚スキャンデール女王の非難サーブアピアロードマップレインルール管理プルコールド通知音声エド。完全に定義されたフライドロップリードクライダークカーノート待機計画図スターボックス名詞フィールドレスト真の可能ポンド完了ビューティードライブスタンドキープフロントティーチウィークファイナルギブグリーンオーファスト開発オーシャンヒートフリーミニッツストロングスペシャルマインドピュアテールの背後にあるフルストレングスブルーオブジェクトソルブ表面の深い月の島の足システム忙しいテストタスクレコードボートドライワンダーの代わりに可能な平面合計金笑うリンゴの木レモンの言葉なぜ羨望の長い地球のもの多分知識重複信じられないほどの才能のあるスキルエクササイズスポーツ青赤誰も疑わしい大丈夫間違った人々のもの普通の船の車のバス中央値は常に月曜日が春の終わりになることはありませんが、彼女は失われた海よりも大きな征服をして申し訳ありません最高の国際的なサメ希望に満ちた日曜日の引退した休日訪問医師エンジニアほぼ終了文を追加する必要がありますしかし、火のボスの医療スプリント帝国の州の建物離婚スキャンデール女王の非難 サーブアピアロードマップレインルール管理プルコールド通知音声エド。完全に定義されたフライドロップリードクライダークカーノート待機計画図スターボックス名詞フィールドレスト真の可能ポンド完了ビューティードライブスタンドキープフロントティーチウィークファイナルギブグリーンオーファスト開発オーシャンヒートフリーミニッツストロングスペシャルマインドピュアテールの背後にあるフルストレングスブルーオブジェクトソルブ表面の深い月の島の足システム忙しいテストタスクレコードボートドライワンダーの代わりに可能な平面合計金笑うリンゴの木レモンの言葉なぜ羨望の長い地球のもの多分知識重複信じられないほどの才能のあるスキルエクササイズスポーツ青赤誰も疑わしい大丈夫間違った人々のもの普通の船の車のバス中央値は常に月曜日が春の終わりになることはありませんが、彼女は失われた海よりも大きな征服をして申し訳ありません最高の国際的なサメ希望に満ちた日曜日の引退した休日訪問医師エンジニアほぼ終了文を追加する必要がありますしかし、火のボスの医療スプリント帝国の州の建物離婚スキャンデール女王の非難'
			--Chinese (Simplified)
			WHEN 2052 THEN N'能够再次空气总是和回答周围的任何问题，因为在后面问最好之前最好在黑体书男孩兄弟之间但打电话可以车小心猫椅子机会奶酪儿童电影院清洁清除关闭冷来可以乡村哭剪舞蹈女儿日晚餐做医生文件狗门下来梦想饮料每个容易吃鸡蛋八结束一切解释眼睛脸家庭父亲首先从游戏中为朋友找火得到女孩给好手他头帮助她他的家想法如果重要在信息里面有趣它工作种类知道土地学习生活轻生活长使人很多可能钱更多早上移动我的名字新没有现在经常打开或出页纸公园支付和平笔人人图片地方玩请流行喜欢问题放置问题到达阅读准备好红色休息富右河路房跑同说学校第二次看到发送设置她船店应该显示坐小所以一些儿子很快就会说话站开始石头停止学生这样的桌子，那里他们的事情认为这个t我今天两个明白了很访问等待我们什么地方为什么文字工作写你跨越行动后几乎独自一人已经有任何军队艺术坏漂亮因为成为床大盒子面包早餐带来公共汽车买相机护理携带捕捉导致某些改变首席教会城市班公司确认继续控制角落成本盖文化死亲爱的决定深描述沙漠死困难距离衣服开车干东教育享受足够的晚上每个例子期待昂贵的事实快速感觉很少打花食品免费全车库花园金大绿组快乐难有希望家  多病 不可能 把产业兴趣纳入邀请 海岛旅行 汁液 保持迟到 离开 让信像遇见会员 错过时刻 月 最重要的妈妈 必须永远 永远不要 什么 老 只 其他 个人 个人电话计划播放器警察位置可能的权力礼物总统漂亮的价格产品提供公共相当真实的重新 收到记录 保持记住报告结果返回圆悲伤拯救海座位服务几个应侧单身姐妹t 甚至从来没有检查交换落场电影细鱼地板飞形水果一般礼物高兴玻璃政府增长一半发生听到心高保持小时冰疾病想象立即增加（v）告知昆虫介绍跳转只是关键少行小爱低杂志标记材料的意思能够再次空气总是和回答周围的任何问题，因为在后面问最好之前最好在黑体书男孩兄弟之间但打电话可以车小心猫椅子机会奶酪儿童电影院清洁清除关闭冷来可以乡村哭剪舞蹈女儿日晚餐做医生文件狗门下来梦想饮料每个容易吃鸡蛋八结束一切解释眼睛脸家庭父亲首先从游戏中为朋友找火得到女孩给好手他头帮助她他的家想法如果重要在信息里面有趣它工作种类知道土地学习生活轻生活长使人很多可能钱更多早上移动我的名字新没有现在经常打开或出页纸公园支付和平笔人人图片地方玩请流行喜欢问题放置问题到达阅读准备好红色休息富右河路房跑同说学校第二次看到发送设置她船店应该显示坐小所以一些儿子很快就会说话站开始石头停止学生这样的桌子，那里他们的事情认为这个t我今天两个明白了很访问等待我们什么地方为什么文字工作写你跨越行动后几乎独自一人已经有任何军队艺术坏漂亮因为成为床大盒子面包早餐带来公共汽车买相机护理携带捕捉导致某些改变首席教会城市班公司确认继续控制角落成本盖文化死亲爱的决定深描述沙漠死困难距离衣服开车干东教育享受足够的晚上每个例子期待昂贵的事实快速感觉很少打花食品免费全车库花园金大绿组快乐难有希望家  多病 不可能 把产业兴趣纳入邀请 海岛旅行 汁液 保持迟到 离开 让信像遇见会员 错过时刻 月 最重要的妈妈 必须永远 永远不要 什么 老 只 其他 个人 个人电话计划播放器警察位置可能的权力礼物总统漂亮的价格产品提供公共相当真实的重新 收到记录 保持记住报'
			-- Chinese (Trad)
			WHEN 1028 THEN N'昆蟲介紹跳轉只是關鍵少行小愛低雜誌標記材料的意思能夠再次空氣總是和回答周圍的任何問題，因為在後面問最好之前最好在黑體書男孩兄弟之間但打電話可以車小心貓椅子機會奶酪兒童電影院清潔清除關閉冷來可以鄉村哭剪舞蹈女兒日晚餐做醫生文件狗門下來夢想飲料每個容易吃雞蛋八結束一切解釋眼睛臉家庭父親首先從遊戲中為朋友找火得到女孩給好手他頭幫助她他的家想法如果重要在信息裡面有趣它工作種類知道土地學習生活輕生活長使人很多可能錢更多早上移動我的名字新沒有現在經常打開或出頁紙公園支付和平筆人人圖片地方玩請流行喜歡問題放置問題到達閱讀準備好紅色休息富右河路房跑同說學校第二次看到發送設置她船店應該顯示坐小所以一些兒子很快就會說話站開始石頭停止學生這樣的桌子，那裡他們的事情認為這個t我今天兩個明白了很訪問等待我們什麼地方昆蟲介紹跳轉只是關鍵少行小愛低雜誌標記材料的意思能夠再次空氣總是和回答周圍的任何問題，因為在後面問最好之前最好在黑體書男孩兄弟之間但打電話可以車小心貓椅子機會奶酪兒童電影院清潔清除關閉冷來可以鄉村哭剪舞蹈女兒日晚餐做醫生文件狗門下來夢想飲料每個容易吃雞蛋八結束一切解釋眼睛臉家庭父親首先從遊戲中為朋友找火得到女孩給好手他頭幫助她他的家想法如果重要在信息裡面有趣它工作種類知道土地學習生活輕生活長使人很多可能錢更多早上移動我的名字新沒有現在經常打開或出頁紙公園支付和平筆人人圖片地方玩請流行喜歡問題放置問題到達閱讀準備好紅色休息富右河路房跑同說學校第二次看到發送設置她船店應該顯示坐小所以一些兒子很快就會說話站開始石頭停止學生這樣的桌子，那裡他們的事情認為這個t我今天兩個明白了很訪問等待我們什麼地方昆蟲介紹跳轉只是關鍵少行小愛低雜誌標記材料的意思能夠再次空氣總是和回答周圍的任何問題，因為在後面問最好之前最好在黑體書男孩兄弟之間但打電話可以車小心貓椅子機會奶酪兒童電影院清潔清除關閉冷來可以鄉村哭剪舞蹈女兒日晚餐做醫生文件狗門下來夢想飲料每個容易吃雞蛋八結束一切解釋眼睛臉家庭父親首先從遊戲中為朋友找火得到女孩給好手他頭幫助她他的家想法如果重要在信息裡面有趣它工作種類知道土地學習生活輕生活長使人很多可能錢更多早上移動我的名字新沒有現在經常打開或出頁紙公園支付和平筆人人圖片地方玩請流行喜歡問題放置問題到達閱讀準備好紅色休息富右河路房跑同說學校第二次看到發送設置她船店應該顯示坐小所以一些兒子很快就會說話站開始石頭停止學生這樣的桌子，那裡他們的事情認為這個t我今天兩個明白了很訪問等待我們什麼地方昆蟲介紹跳轉只是關鍵少行小愛低雜誌標記材料的意思能夠再次空氣總是和回答周圍的任何問題，因為在後面問最好之前最好在黑體書男孩兄弟之間但打電話可以車小心貓椅子機會奶酪兒童電影院清潔清除關閉冷來可以鄉村哭剪舞蹈女兒日晚餐做醫生文件狗門下來夢想飲料每個容易吃雞蛋八結束一切解釋眼睛臉家庭父親首先從遊戲中為朋友找火得到女孩給好手他頭幫助她他的家想法如果重要在信息裡面有趣它工作種類知道土地學習生活輕生活長使人很多可能錢更多早上移動我的名字新沒有現在經常打開或出頁紙公園支付和平筆人人圖片地方玩請流行喜歡問題放置問題到達閱讀準備好紅色休息富右河路房跑同說學校第二次看到發送設置她船店應該顯示坐'
			--Arabic
			WHEN 1025 THEN N'قفزة مقدمة الحشرات هي فقط المفتاح. معنى مادة تسمية المجلة هو أن تكون قادرًا على البث مرة أخرى والإجابة دائمًا على أي أسئلة حولك ، لأنه من الأفضل أن تكون بين الأولاد والإخوة في الكتاب الأسود قبل أن تسأل ، ولكنك يمكن أن تكون حذرا عند الاتصال.فرصة كرسي القط جبن سينما الأطفال نظيفة واضحة مغلقة برد تعال هل يمكن للبلد قطع البكاء الرقص يوم الابنة العشاء تفعل ملف الطبيب باب الكلب أسفل الحلم يشرب كل شيء سهل أكل البيض ثمانية نهاية كل شيء يشرح العيون وجه الأسرة الأب يجد النار أولاً للأصدقاء من اللعبة للحصول على الفتاة ، أعطها يدًا جيدة ، ساعدها ، ساعدها ، فكرة منزله ، إذا كانت مهمة ، فهي مثيرة للاهتمام في المعلومات ، نوع العمل يعرف الأرض ، الدراسة ، الحياة ، الحياة طويلة ، يجعل الناس أكثر ممكناً ، المال يتحرك أكثر في الصباح ، اسمي جديد ، ليس الآن مفتوحًا أو خارج الحديقة الورقية في كثير من الأحيان لدفع  الصور أماكن للعب من فضلك Pop Like أسئلة التنسيب الوصول القراءة جاهز جاهز جاهز للراحة الحمراء فو يوهه الطريق غرفة تشغيل مدرسة تونغ سعيد المرة الثانية التي أرى فيها إرسال إعداد متجر القوارب الخاص بها يجب أن يظهر الجلوس صغيرًا لذا سيتحدث بعض الأبناء قريبًا بدأت في الوقوف وأوقفت الطلاب على الطاولة هكذا ، حيث اعتقدوا ذلك لقد فهمت ذلك كثيرًا لزيارة ما ينتظرنا اليومالمال يتحرك أكثر في الصباح ، اسمي جديد ، ليس الآن مفتوحًا أو خارج الحديقة الورقية في كثير من الدة ، ساعدها ، ساعدها ، فكرة منزله ، إذا كانت مهمة -'

            ELSE 'a ac accumsan ad adipiscing aenean aliquam aliquet amet ante aptent arcu at auctor augue bibendum blandit class commodo condimentum congue consectetuer consequat conubia convallis cras cubilia cum curabitur curae; cursus dapibus diam dictum dignissim dis dolor donec dui duis egestas eget eleifend elementum elit enim erat eros est et etiam eu euismod facilisi facilisis fames faucibus felis fermentum feugiat fringilla fusce gravida habitant hendrerit hymenaeos iaculis id imperdiet in inceptos integer interdum ipsum justo lacinia lacus laoreet lectus leo libero ligula litora lobortis lorem luctus maecenas magna magnis malesuada massa mattis mauris metus mi molestie mollis montes morbi mus nam nascetur natoque nec neque netus nibh nisi nisl non nonummy nostra nulla nullam nunc odio orci ornare parturient pede pellentesque penatibus per pharetra phasellus placerat porta porttitor posuere praesent pretium primis proin pulvinar purus quam quis quisque rhoncus ridiculus risus rutrum sagittis sapien scelerisque sed sem semper senectus sit sociis sociosqu sodales sollicitudin suscipit suspendisse taciti tellus tempor tempus tincidunt torquent tortor tristique turpis ullamcorper ultrices ultricies urna ut varius vehicula vel velit venenatis vestibulum vitae vivamus viverra volutpat vulputate'
        END;



        DECLARE @v_max_words smallint; 
        DECLARE @v_random_item smallint =0;
		DECLARE @v_random_char smallint =0;
        DECLARE @v_random_word NVARCHAR(25);
        DECLARE @v_result NVARCHAR(max)=null;
        DECLARE @v_iter smallint=1;
        --DECLARE @v_text_lipsum VARCHAR(1500) = 'a ac accumsan ad adipiscing aenean aliquam aliquet amet ante aptent arcu at auctor augue bibendum blandit class commodo condimentum congue consectetuer consequat conubia convallis cras cubilia cum curabitur curae; cursus dapibus diam dictum dignissim dis dolor donec dui duis egestas eget eleifend elementum elit enim erat eros est et etiam eu euismod facilisi facilisis fames faucibus felis fermentum feugiat fringilla fusce gravida habitant hendrerit hymenaeos iaculis id imperdiet in inceptos integer interdum ipsum justo lacinia lacus laoreet lectus leo libero ligula litora lobortis lorem luctus maecenas magna magnis malesuada massa mattis mauris metus mi molestie mollis montes morbi mus nam nascetur natoque nec neque netus nibh nisi nisl non nonummy nostra nulla nullam nunc odio orci ornare parturient pede pellentesque penatibus per pharetra phasellus placerat porta porttitor posuere praesent pretium primis proin pulvinar purus quam quis quisque rhoncus ridiculus risus rutrum sagittis sapien scelerisque sed sem semper senectus sit sociis sociosqu sodales sollicitudin suscipit suspendisse taciti tellus tempor tempus tincidunt torquent tortor tristique turpis ullamcorper ultrices ultricies urna ut varius vehicula vel velit venenatis vestibulum vitae vivamus viverra volutpat vulputate';
        DECLARE @v_text_lipsum_wordcount smallint = 180;
		DECLARE @v_text_lipsum_charcount smallint = 1295;
        DECLARE @v_sentence_wordcount smallint= 0;
        DECLARE @v_sentence_start smallint = 1;
        DECLARE @v_sentence_end smallint = 0;
        DECLARE @v_sentence_lenght smallint = 9;
		DECLARE @v_rdnb smallint = 9;

		/*DECLARE @RtnValue DECIMAL(18,4);
		SET @v_max_words = (select random_value from random_val_view) * (1/100.0)*/
		/*SET @v_max_words =  RAND();*/
       SET @v_max_words = FLOOR(5+(Len(@Input)/5) + 5) -- ((select random_value from random_val_view) * @v_text_lipsum_wordcount));
	   SET @v_sentence_lenght = FLOOR(5 + ((select random_value from random_val_view) *10));
        
		DECLARE @LenOutput int = 0;
		DECLARE @LenInput int = LEN(@Input);

        --WHILE @v_iter <= @v_max_words 
		WHILE (@LenOutput<@LenInput)
		BEGIN

            /*SET @v_random_item = FLOOR(1 + (RAND() * @v_text_lipsum_wordcount));*/
			 --SET @v_random_item = FLOOR(1 + ((select random_value from random_val_view) * @v_text_lipsum_wordcount));
			/*SET @v_random_char = FLOOR(1 + (RAND() * @v_text_lipsum_charcount));*/
			 SET @v_random_char = FLOOR(1 + ((select random_value from random_val_view) * @v_text_lipsum_charcount));
			 SET @v_rdnb =FLOOR(5 + ((select random_value from random_val_view) *5))
			 SET @v_random_word = SUBSTRING (@v_text_lipsum, @v_random_char , @v_rdnb); --+  @v_random_char
			 SET  @v_random_word=replace(@v_random_word, ' ', ''); 

            SET @v_sentence_wordcount = @v_sentence_wordcount + 1;
			
            IF @v_sentence_wordcount = @v_sentence_lenght 
			BEGIN
                SET @v_sentence_end = 1 ;
            END;

			/*Majuscule début de phrase*/
			/*
            IF @v_sentence_start = 1
			BEGIN
                SET @v_random_word = CONCAT(UPPER(SUBSTRING(@v_random_word, 1, 1))
                                            ,LOWER(SUBSTRING(@v_random_word, 2,DATALENGTH ( @v_random_word) )));
                SET @v_sentence_start = 0 ;
            END;
			*/
			
            IF @v_sentence_end = 1 
			BEGIN
				
                IF @v_iter <> @v_max_words 
				BEGIN
                    SET @v_random_word = CONCAT(@v_random_word, '.');
                END ;
                /*SET @v_sentence_lenght = FLOOR(9 + (RAND() * 7));*/
				 SET @v_sentence_lenght = FLOOR(5 + ((select random_value from random_val_view) *5));


                SET @v_sentence_end = 0 ;
                --SET @v_sentence_start = 1 ;
                SET @v_sentence_wordcount = 0 ;
            END;

            SET @v_result = CONCAT(@v_result,' ', @v_random_word);
            SET @v_iter = @v_iter + 1;


			SET @LenOutput=LEN(@v_result)


        END;
		
        --SET @v_result = LEFT(CONCAT(@v_result,'a.'),Len(@Input));
		--SET @v_result = RIGHT('a'+LEFT(@v_result+'a',1+Len(@Input)),1+Len(@Input))     
		
		SET @v_result =TRIM(SUBSTRING (@v_result ,0 , 1+Len(@Input) )) ;
		IF LEN(@v_result)<LEN(@Input)         
		BEGIN
			SET @v_result=@v_result+'a';
		END;
		IF LEN(@v_result)<LEN(@Input)         
		BEGIN
			SET @v_result=@v_result+'b';
		END;

		--SET @v_result = CONCAT(@v_result,NULL,'.');
	
		RETURN @v_result;
		
END;

--DROP FUNCTION [dbo].lipsum--  @Input VARCHAR(4096), @language int)