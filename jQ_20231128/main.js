console.log("main.js!!");

const ATTRIBUTION = '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors';
const ACCESS_TOKEN = "アクセストークン";

$(document).ready(()=>{
	console.log("Ready");

	// Leaflet x Axios

	// Leaflet
	const center = [35.363357, 136.617586];
	let map = L.map("mapid").setView(center, 15);
	L.tileLayer("http://{s}.tile.osm.org/{z}/{x}/{y}.png", {
		attribution: ATTRIBUTION,// 著作権表記
		accessToken: ACCESS_TOKEN,// アクセストークン
		id: "mapbox/streets-v11",// マップの種類
	}).addTo(map);

	// マーカーを1個置いてみる!!
	// L.marker(center).addTo(map);
	// L.marker([35.363357, 136.62]).addTo(map);
	// L.marker([35.353357,136.625]).addTo(map);

	// Axios
	const option={"responseType":"blob"};
	axios.get("./data.json",option).then(res=>{
		console.log("読み込み成功:",res);
		// オブジェクト->文字列へ
		res.data.text().then(str=>{
			console.log("文字列に変換:",str);
		//文字列->JSONオブジェクト
		const jOdj=JSON.parse(str);
		console.log("JSONオブジェクト:",jOdj);
		console.log("JSONオブジェクト:",jOdj.data[0].name);
		console.log("JSONオブジェクト:",jOdj.data[1]);
		console.log("JSONオブジェクト:",jOdj.data[2]);
		console.log("JSONオブジェクト:",jOdj.data[3]);
		// for文で一つづつ取り出す
		for(let toilet of jOdj.data){

			console.log(toilet.name,toilet.lat,toilet.lng);
		// TODO:mapにピンを配置せよ
		L.marker(toilet).addTo(map);
		// TODO:id=listにトイレの名前とその緯度経度を表示する事
		
		$("#list").text(toilet.name,toilet.lat,toilet.lng);
		
		}
		});
	}).catch(err=>{
		console.log("読み込み失敗...");
	});
});