#!/usr/bin/perl

use common::sense;
use Data::Dumper;
use LWP::UserAgent;
use HTML::TreeBuilder;
#use URI::Escape;

# 検索のキーを準備 XXXXX
=ayano
my $prec = [ {name => "宗谷地方", value => 11},
			 {name => "上川地方", value => 12},
			 {name => "留萌地方", value => 13},
			 {name => "石狩地方", value => 14},
			 {name => "空知地方", value => 15},
			 {name => "後志地方", value => 16},
			 {name => "網走・北見・紋別地方", value => 17},
			 {name => "根室地方", value => 18},
			 {name => "釧路地方", value => 19},
			 {name => "十勝地方", value => 20},
			 {name => "胆振地方", value => 21},
			 {name => "日高地方", value => 22},
			 {name => "渡島地方", value => 23},
			 {name => "檜山地方", value => 24},
			 {name => "青森県",   value => 31},
			 {name => "秋田県",   value => 32},
			 {name => "岩手県",   value => 33},
			 {name => "宮城県", value => 34},
			 {name => "山形県", value => 35},
			 {name => "福島県", value => 36},
			 {name => "茨城県", value => 40},
			 {name => "栃木県", value => 41},
			 {name => "群馬県", value => 42},
			 {name => "埼玉県", value => 43},
			 {name => "東京都", value => 44},
			 {name => "千葉県", value => 45},
			 {name => "神奈川県", value => 46},
			 {name => "長野県", value => 48},
			 {name => "山梨県", value => 49},
			 {name => "静岡県", value => 50},
			 {name => "愛知県", value => 51},
			 {name => "岐阜県", value => 52},
			 {name => "三重県", value => 53},
			 {name => "新潟県", value => 54},
			 {name => "富山県", value => 55},
			 {name => "石川県", value => 56},
			 {name => "福井県", value => 57},
			 {name => "滋賀県", value => 60},
			 {name => "京都府", value => 61},
			 {name => "大阪府", value => 62},
			 {name => "兵庫県", value => 63},
			 {name => "奈良県", value => 64},
			 {name => "和歌山県", value => 65},
			 {name => "岡山県", value => 66},
			 {name => "広島県", value => 67},
			 {name => "島根県", value => 68},
			 {name => "鳥取県", value => 69},
			 {name => "徳島県", value => 71},
			 {name => "香川県", value => 72},
			 {name => "愛媛県", value => 73},
			 {name => "高知県", value => 74},
			 {name => "山口県", value => 81},
			 {name => "福岡県", value => 82},
			 {name => "大分県", value => 83},
			 {name => "長崎県", value => 84},
			 {name => "佐賀県", value => 85},
			 {name => "熊本県", value => 86},
			 {name => "宮崎県", value => 87},
			 {name => "鹿児島県", value => 88},
			 {name => "沖縄県", value => 91},
			 {name => "南極"  , value => 99},
	];

my $block =[ {name => "白糸", value => 0440},
			 {name => "御殿場",value => 0441},
			 {name => "富士", value => 0442 },
			 {name => "三島", value => 47657 },
			 {name => "越木平", value =>0444 },
			 {name => "川根本町", value => 0445}, 
			 {name => "大山", value => 0446 },
			 {name => "網代", value => 47668 },
			 {name => "高根山", value => '0448' },
			 {name => "静岡", value => 47656 },
			 {name => "霧山", value =>450 },
			 {name => "天竜", value => '0451' },
			 {name => "島田", value => '0452' },
			 {name => "湯ケ島", value => 0453}, 
			 {name => "天城山", value => 0454 },
			 {name => "浜松", value =>47654 },
			 {name => "松崎", value => 0456 },
			 {name => "稲取", value => 0457 },
			 {name => "御前崎", value => 47655}, 
			 {name => "石廊崎", value => 47666 },
			 {name => "佐久間", value =>0986 },
			 {name => "土肥", value => 0987 },
			 {name => "三ヶ日", value =>988 },
			 {name => "掛川", value => 0989 },
			 {name => "熊", value =>105 },
			 {name => "三倉", value => 1106}, 
			 {name => "梅ケ島", value => 1114}, 
			 {name => "清水", value => 1243 },
			 {name => "磐田", value => 1244 },
			 {name => "菊川牧之原", value => 1335}, 
			 {name => "井川", value => 1338 },
			 {name => "三倉", value => 1393 },
			 {name => "鍵穴", value => 1440 },
			 {name => "富士山", value =>7639 }];

=cut

# 気象庁のサイトにアクセスしてデータを取得
#for (@block){

    my $p = 50;    # 静岡県 XXX
	my $b = 47656; # 静岡   XXX
	my $url = "http://www.data.jma.go.jp/obd/stats/etrn/view/hourly_s1.php?prec_no=$p&block_no=$b&year=2011&month=6&day=24&elm=hourly&view=";
	print $url ."\n";

    # LWP = PerlでWWWアクセスするためのライブラリでHTMLの内容を取得
	my $ua  = LWP::UserAgent->new;
	my $res = $ua->get($url);
	my $content = $res->content;

    # HTML::TreeBuilderで解析する
	my $tree = HTML::TreeBuilder->new;
	$tree->parse($content);

    # データの部分を抽出する
	my @title = $tree->find('h3');
	print $_->as_text . "\n" for @title;
	print '-------------'. "\n";
	my @items = $tree->look_down('id','tablefix1')->find('td');
	print $_->as_text . "\n" for @items;

#}
