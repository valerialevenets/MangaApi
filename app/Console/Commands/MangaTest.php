<?php

namespace App\Console\Commands;

use App\MangaResources\Metadata\Kitsu\Api;
use App\MangaResources\Metadata\Kitsu\Kitsu;
use Illuminate\Console\Command;

class MangaTest extends Command
{
    public function __construct(private readonly Kitsu $kitsu, private readonly Api $api)
    {
        parent::__construct();


    }

    protected $signature = 'manga:test';
    protected $description = 'just command for test';

    public function handle()
    {
        $this->kitsu->init();
        dd($this->kitsu->getMangaById(13612));
    }
}
