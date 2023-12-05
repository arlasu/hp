console.log("main.js!!");

let counter = 0;

$(document).ready(()=>{
	console.log("Ready!!");
	// インターバル
	setInterval(()=>{
		console.log("時間と日付が表示する所だよ!!",counter);
		counter++; //+1
		// TODO: #msg_1にカウンターを表示させよう!
		$("#msg_1").text(counter);

		// 年月日 
		const dObj=new Date();//Dateオブジェクト
		console.log(dObj);
		const newYear=dObj.getFullYear();//年
		const newMonth=dObj.getMonth()+1;//月
		const newDate=dObj.getDate();//日
		console.log(newYear,newMonth,newDate);
		// TODO: msg_2に、年月日を表示させよう!
		$("#msg_2").text(newYear + "/" + newMonth + "/" + newDate);
		// 時分秒
		 var numHours=dObj.getHours();//時
		var numMinutes=dObj.getMinutes();//分
		var numSeconds=dObj.getSeconds();//秒
		// Discordにあるゼロパディング
		// hours = hours < 10 ? '0' + hours : hours;
       // minutes = minutes < 10 ? '0' + minutes : minutes;
       // seconds = seconds < 10 ? '0' + seconds : seconds;
		console.log(numHours,numMinutes,numSeconds);
		// TODO: 時:秒:を#msg_3に表示させよう!
		$("#msg_3").text(numHours + ":" + numMinutes + ":" + numSeconds);
		// TODO: 一桁の時は、先頭に0を付けたいなー...
		
	},1000);
});
