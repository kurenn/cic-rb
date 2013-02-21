# CIC Ruby Gem

cic-rb is a client which communicates with the CIC API, and interact
with it

It was developed for usage in Ruby on Rails web applications, but it
also works as a standalone library

## Installation

Add this line to your application's Gemfile:

	gem 'cic'

Living on the edge

	gem 'cic', git: 'git@github.com:IcaliaLabs/cic-rb.git'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cic 

Request for reports 
---

```ruby	
Cic::Report.all
```	
It will output:
```ruby	
#<Cic::Report:0x007fb0a0874f58
  @attributes=
   {"ticket"=>"#7LZA",
    "content"=>
     "ACCIDENTE* en Vasconcelos lateral para tomar el t\u00FAnel SP #mtyfollow 16:26 v\u00EDa @Monitores_SPGG cc @SanPedroen72",
    "state"=>"read",
    "created_at"=>"2013-02-21T16:29:30-06:00",
    "updated_at"=>"2013-02-21T16:34:15-06:00",
    "lat"=>"25.65419634916782",
    "lng"=>"-100.33913254737848",
    "is_public"=>true,
    "votes"=>0,
    "stars"=>0.0,
    "address_detail"=>{...},
    "group"=>"Vialidad y Transito (SS)",
    "categories"=>["ACCIDENTE"]},
  @raw_attributes=
   {"ticket"=>"#7LZA",
    "content"=>
     "ACCIDENTE* en Vasconcelos lateral para tomar el t\u00FAnel SP #mtyfollow 16:26 v\u00EDa @Monitores_SPGG cc @SanPedroen72",
    "state"=>"read",
    "created_at"=>"2013-02-21T16:29:30-06:00",
    "updated_at"=>"2013-02-21T16:34:15-06:00",
    "lat"=>"25.65419634916782",
    "lng"=>"-100.33913254737848",
    "is_public"=>true,
    "votes"=>0,
    "stars"=>0.0,
    "address_detail"=>
     {"formatted_address"=>
       "Jos\u00E9 Vasconcelos 419, Residencial San Agust\u00EDn 1er Sector, 66260 San Pedro Garza Garc\u00EDa, Nuevo Le\u00F3n, Mexico",
      "zipcode"=>"66260",
      "county"=>
       {"long_name"=>"San Pedro Garza Garc\u00EDa",
        "short_name"=>"San Pedro Garza Garc\u00EDa"},
      "state"=>{"long_name"=>"Nuevo Leon", "short_name"=>"NL"},
      "neighborhood"=>
       {"long_name"=>"Residencial San Agust\u00EDn 1er Sector",
        "short_name"=>"Residencial San Agust\u00EDn 1er Sector"}},
    "group"=>"Vialidad y Transito (SS)",
    "categories"=>["ACCIDENTE"]}>
```	

We have a where clause to embrace em all!

```ruby
Cic::Report.where(for_group: 142)
```

Heads up!, the params you can send are, for_group, for_category, limit, until

It will have the same output as above.
		
Request for categories 
---

```ruby	
Cic::Category.all
```	
	It will output:
	
```ruby	
#<Cic::Category:0x007fb0a28e2d58
  @attributes=
   {"id"=>420,
    "name"=>"AVISOS",
    "metadata"=>false,
    "type"=>"blackbox",
    "group"=>["Comunidad"]},
  @raw_attributes=
   {"id"=>420,
    "name"=>"AVISOS",
    "metadata"=>false,
    "type"=>"blackbox",
    "group"=>["Comunidad"]}>,
#<Cic::Category:0x007fb0a28e2bf0
  @attributes=
   {"id"=>412,
    "name"=>"BACHE O VIA DA\u00D1ADA",
    "metadata"=>false,
    "type"=>"blackbox",
    "group"=>["Servicios Publicos (CS)"]},
  @raw_attributes=
   {"id"=>412,
    "name"=>"BACHE O VIA DA\u00D1ADA",
    "metadata"=>false,
    "type"=>"blackbox",
    "group"=>["Servicios Publicos (CS)"]}>
```	

Request for groups 
---
```ruby	
Cic::Group.all
```	
	It will output:
	
```ruby	
#<Cic::Group:0x007fb0a1c1b610
  @attributes=
   {"id"=>142, "name"=>"Asesorias Generales", "categories"=>[["OTROS", 424]]},
  @raw_attributes=
   {"id"=>142, "name"=>"Asesorias Generales", "categories"=>[["OTROS", 424]]}>,
#<Cic::Group:0x007fb0a1c1b4f8
  @attributes=
   {"id"=>258, "name"=>"CFE", "categories"=>[["FALTA ELECTRICIDAD", 423]]},
  @raw_attributes=
   {"id"=>258, "name"=>"CFE", "categories"=>[["FALTA ELECTRICIDAD", 423]]}>,
```	

## Hashie that out!

Thanks to Hashie library you can access the report attributes by the key value and/or chaining them
	
```ruby	
report = Cic::Report.find('#Y1UI')

report.ticket
#=> '#Y1UI'

category = Cic::Category.all.first
category.name
#=> "AVISOS"

group = Cic::Group.all.first
group.name
#=> "Asesorias Generales"
```
		
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Changelog
<ul>
  <li>Current gem version 0.0.1</li>
	<li>Refactor for code reuse</li>
	<li>GET requests for all entities</li>
</ul>


## Devs
<ul>
  <li>Abraham Kuri Vargas (@kurenn)</li>
</ul>

## Future
<ul>
  <li>Add post method to create reports</li>
</ul>


## Credits
Icalia Labs - weare@icalialabs.com

[Follow us](http://twitter.com/icalialabs "Follow us")


[Like us on Facebook](https://www.facebook.com/icalialab "Like us on Facebook")

## License
Copyright (c) 2011 Icalia Labs

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/gpl.html.
