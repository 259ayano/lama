#!/usr/bin/env perl

# 日本語⇔English

use common::sense;
use Data::Dumper;
use Lingua::JA::Romanize::Japanese;
use LWP::UserAgent;
use HTML::TreeBuilder;
use URI::Escape;

# 日本語(漢字)をローマ字に変換

my $ljrj = Lingua::JA::Romanize::Japanese->new();
my $kanji = $ARGV[0];
my @roma = split '/', $ljrj->char($kanji);


# カタカナを英語に変換

my $ua = LWP::UserAgent->new;
my $katakana = "オクラホマ";
my $url = "http://dictionary.goo.ne.jp/srch/all/$katakana/m1u/";

####### 上のはやめた #######

# GoogleMapのAPIで地名を取得する。


