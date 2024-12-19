console.log("main.js!!");

$(document).ready(()=>{
	console.log("Ready");

	const url="https://www.jma.go.jp/bosai/forecast/data/forecast/130000.json";//アクセスするファイル
	const option={"responseType":"blob"};//オプション
	axios.get(url,option).then(res=>{
		console.log("通信成功!!");
		//データを文字列に変換する
		res.data.text().then(str=>{
			//文字列をJSON変換する
			const jObj=JSON.parse(str);
			console.table(jObj);//テーブル形式で確認
			//TODO:データを抜き出してみる
			console.log(jObj[0].publishingffice);//気象庁
			console.log(jObj[0].timeSeries[0].areas[0].area.name);//東京地方
			$("#msg_1").text(jObj[0].timeSeries[0].areas[0].area.name);
			console.log(jObj[0].timeSeries[0].areas[1].area.name);//?
			console.log(jObj[0].timeSeries[0].areas[2].area.name);//?
			console.log(jObj[0].timeSeries[0].areas[3].area.name);//?
			// 東京の天気情報を取得し、jQueryで表示する事!!
			// weatherCode <-これも配列になっている
			console.log(jObj[0].timeSeries[0].areas[0].weatherCodes[0]);//東京 0
			console.log(jObj[0].timeSeries[0].areas[0].weatherCodes[1]);//東京 1
			console.log(jObj[0].timeSeries[0].areas[0].weatherCodes[2]);//東京 2
			$("#msg_2").text(jObj[0].timeSeries[0].areas[0].weatherCodes[0]);
			
			// weathers
			console.log(jObj[0].timeSeries[0].areas[0].weathers[0]);
			$("#msg_3").text(jObj[0].timeSeries[0].areas[0].weathers[0]);
			// winds
			console.log(jObj[0].timeSeries[0].areas[0].winds[0]);
			$("#msg_4").text(jObj[0].timeSeries[0].areas[0].winds[0]);
		});
	}).catch(err=>{
		console.log("通信失敗...");
	});
});