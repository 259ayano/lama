#!/usr/bin/env perl

# 日本語⇔English

use common::sense;
use Data::Dumper;
use Lingua::JA::Romanize::Japanese;


my $conv = Lingua::JA::Romanize::Japanese->new();

# 日本語(漢字)をローマ字に変換

my $kanji = "文";
my @roma = split '/', $conv->char($kanji);

warn Dumper \@roma;


