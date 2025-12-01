<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.40.5-Bratislava" styleCategories="Symbology|Fields|Forms|AttributeTable|Relations">
  <renderer-v2 type="RuleRenderer" symbollevels="1" enableorderby="0" forceraster="0" referencescale="-1">
    <rules key="{1e60e989-c079-4d86-bb25-9aea44969921}">
      <rule key="{a6926cdb-ca80-461c-b764-5f4bc465c044}" filter=" substr( identif, 2, 1) = 'U'" symbol="0" label="localisation urbis"/>
      <rule key="{8996c85d-cf68-470c-8d33-b87215fb7513}" filter=" substr( identif, 2, 1) = 'A'" symbol="1" label="Numéro localisé dans la rue"/>
      <rule key="{8554b40a-ff07-4de1-9259-66f4b175e04d}" filter=" substr( identif, 2, 1) = 'B'" symbol="2" label="Numéro non localisé"/>
      <rule key="{adc604f9-decf-410e-a118-98dfac7c2f66}" filter="abs (&quot;annee&quot;  -  &quot;annee_ref&quot;) &lt; 20" symbol="3" label="Bonne correspondance temporelle"/>
      <rule checkstate="0" key="{2161ff48-3d12-462a-b80f-9c638b4d107a}" filter="abs (&quot;annee&quot;  -  &quot;annee_ref&quot;) >= 20  AND abs (&quot;annee&quot;  -  &quot;annee_ref&quot;) &lt; 50" symbol="4" label="Faible correspondance temporelle"/>
      <rule key="{57fe95e5-3a68-4df9-860c-84be2393b6c6}" filter="abs (&quot;annee&quot;  -  &quot;annee_ref&quot;) >= 50" symbol="5" label="Pas de correspondance temporelle"/>
      <rule key="{be2cd4cc-eddd-47b9-b862-24e037f6bcdf}" filter="substr( &quot;identif&quot; , 5, 1) = '4'" symbol="6" label="Type de voirie ne correspond pas"/>
      <rule key="{633307bd-fe3a-4bca-b693-e9ab1d9d41d8}" filter=" substr( identif, 3, 1) NOT IN ('A', 'B', 'C') OR  substr( identif, 2, 1) NOT IN ('A', 'B', 'C', 'U')" symbol="7" label="Autre"/>
      <rule key="{2b97190b-cf61-4501-a06e-cb387c6d5164}" filter=" &quot;muni_short_in&quot; != &quot;muni_short_out&quot; and dist_muni > 25" symbol="8" label="Commune modifiée"/>
    </rules>
    <symbols>
      <symbol type="marker" frame_rate="10" name="0" is_animated="0" alpha="1" clip_to_extent="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleMarker" id="{d5338f3e-97db-4f21-a8a4-d316e7982474}" enabled="1" locked="0" pass="1">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="58,128,28,255,rgb:0.22745098039215686,0.50196078431372548,0.10980392156862745,1" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="circle" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="254,142,49,255,rgb:0.99607843137254903,0.55686274509803924,0.19215686274509805,1" name="outline_color"/>
            <Option type="QString" value="solid" name="outline_style"/>
            <Option type="QString" value="0" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="5" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol type="marker" frame_rate="10" name="1" is_animated="0" alpha="1" clip_to_extent="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleMarker" id="{5b3236df-468e-40ec-988b-0e272d77f66f}" enabled="1" locked="0" pass="1">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="58,128,28,255,rgb:0.22745098039215686,0.50196078431372548,0.10980392156862745,1" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="circle" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="255,255,255,255,rgb:1,1,1,1" name="outline_color"/>
            <Option type="QString" value="solid" name="outline_style"/>
            <Option type="QString" value="0" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="5" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol type="marker" frame_rate="10" name="2" is_animated="0" alpha="1" clip_to_extent="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleMarker" id="{6e5f24f8-71e0-46fd-8434-91e24667bcda}" enabled="1" locked="0" pass="1">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="146,158,204,255,rgb:0.5725490196078431,0.61960784313725492,0.80000000000000004,1" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="circle" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="14,36,181,255,rgb:0.05490196078431372,0.14117647058823529,0.70980392156862748,1" name="outline_color"/>
            <Option type="QString" value="solid" name="outline_style"/>
            <Option type="QString" value="0.6" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="5" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol type="marker" frame_rate="10" name="3" is_animated="0" alpha="1" clip_to_extent="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleMarker" id="{f470bd3a-d9d7-438b-9301-c7089939ba39}" enabled="1" locked="0" pass="2">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="58,128,28,255,rgb:0.22745098039215686,0.50196078431372548,0.10980392156862745,1" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="circle" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="0,0,0,255,rgb:0,0,0,1" name="outline_color"/>
            <Option type="QString" value="no" name="outline_style"/>
            <Option type="QString" value="0" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="2" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol type="marker" frame_rate="10" name="4" is_animated="0" alpha="1" clip_to_extent="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleMarker" id="{05b4da29-d642-4cc7-8ba5-00b525a1000c}" enabled="1" locked="0" pass="2">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="238,241,95,255,rgb:0.93333333333333335,0.94509803921568625,0.37254901960784315,1" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="circle" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="0,0,0,255,rgb:0,0,0,1" name="outline_color"/>
            <Option type="QString" value="no" name="outline_style"/>
            <Option type="QString" value="0" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="2" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol type="marker" frame_rate="10" name="5" is_animated="0" alpha="1" clip_to_extent="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleMarker" id="{324b0bfc-af41-4ecd-a6cd-259f20ff7e88}" enabled="1" locked="0" pass="2">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="235,66,47,255,rgb:0.92156862745098034,0.25882352941176473,0.18431372549019609,1" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="circle" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="0,0,0,255,rgb:0,0,0,1" name="outline_color"/>
            <Option type="QString" value="no" name="outline_style"/>
            <Option type="QString" value="0" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="2" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol type="marker" frame_rate="10" name="6" is_animated="0" alpha="1" clip_to_extent="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleMarker" id="{62cf21f7-52c3-47ab-a3d2-f24cf52c4d99}" enabled="1" locked="0" pass="5">
          <Option type="Map">
            <Option type="QString" value="45" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="169,15,200,255,rgb:0.66274509803921566,0.05882352941176471,0.78431372549019607,1" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="star_diamond" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="252,255,247,255,rgb:0.9882352941176471,1,0.96862745098039216,1" name="outline_color"/>
            <Option type="QString" value="solid" name="outline_style"/>
            <Option type="QString" value="0" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="4.8" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol type="marker" frame_rate="10" name="7" is_animated="0" alpha="1" clip_to_extent="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleMarker" id="{73df8c8d-ca16-4119-a892-0f5214379584}" enabled="1" locked="0" pass="3">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="90,13,67,255,rgb:0.35294117647058826,0.05098039215686274,0.2627450980392157,1" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="circle" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="0,0,0,255,rgb:0,0,0,1" name="outline_color"/>
            <Option type="QString" value="no" name="outline_style"/>
            <Option type="QString" value="0" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="4" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol type="marker" frame_rate="10" name="8" is_animated="0" alpha="1" clip_to_extent="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleMarker" id="{0f88820f-3ab7-4719-999b-fdf547a3cf7d}" enabled="1" locked="0" pass="4">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="103,0,13,0,rgb:0.40392156862745099,0,0.05098039215686274,0" name="color"/>
            <Option type="QString" value="0" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="triangle" name="name"/>
            <Option type="QString" value="-5,-3.20000000000000018" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="198,41,25,255,rgb:0.77647058823529413,0.16078431372549021,0.09803921568627451,1" name="outline_color"/>
            <Option type="QString" value="solid" name="outline_style"/>
            <Option type="QString" value="0.6" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="3.4" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="2" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="offset">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="tostring(-1.47059*(coalesce(scale_exp(&quot;dist_muni&quot;, 2, 18000, 1.5, 9, 0.57), 0)))|| ',' || tostring(-0.941176*(coalesce(scale_exp(&quot;dist_muni&quot;, 2, 18000, 1.5, 9, 0.57), 0)))" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
                <Option type="Map" name="outlineColor">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="dist_muni" name="field"/>
                  <Option type="Map" name="transformer">
                    <Option type="Map" name="d">
                      <Option type="Map" name="colorramp">
                        <Option type="QString" value="[source]" name="name"/>
                        <Option type="Map" name="properties">
                          <Option type="QString" value="254,240,217,255,rgb:0.99607843137254903,0.94117647058823528,0.85098039215686272,1" name="color1"/>
                          <Option type="QString" value="179,0,0,255,rgb:0.70196078431372544,0,0,1" name="color2"/>
                          <Option type="QString" value="ccw" name="direction"/>
                          <Option type="QString" value="0" name="discrete"/>
                          <Option type="QString" value="gradient" name="rampType"/>
                          <Option type="QString" value="rgb" name="spec"/>
                          <Option type="QString" value="0.25;253,204,138,255,rgb:0.99215686274509807,0.80000000000000004,0.54117647058823526,1;rgb;ccw:0.5;252,141,89,255,rgb:0.9882352941176471,0.55294117647058827,0.34901960784313724,1;rgb;ccw:0.75;227,74,51,255,rgb:0.8901960784313725,0.29019607843137257,0.20000000000000001,1;rgb;ccw" name="stops"/>
                        </Option>
                        <Option type="QString" value="gradient" name="type"/>
                      </Option>
                      <Option type="Map" name="curve">
                        <Option type="QString" value="0,0.12812499999999999" name="x"/>
                        <Option type="QString" value="0,0.98901098901098905" name="y"/>
                      </Option>
                      <Option type="double" value="18000" name="maxValue"/>
                      <Option type="double" value="2" name="minValue"/>
                      <Option type="QString" value="93,0,0,255,rgb:0.36470588235294116,0,0,1" name="nullColor"/>
                      <Option type="QString" value="" name="rampName"/>
                    </Option>
                    <Option type="int" value="2" name="t"/>
                  </Option>
                  <Option type="int" value="2" name="type"/>
                </Option>
                <Option type="Map" name="size">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="dist_muni" name="field"/>
                  <Option type="Map" name="transformer">
                    <Option type="Map" name="d">
                      <Option type="double" value="0.57" name="exponent"/>
                      <Option type="double" value="9" name="maxSize"/>
                      <Option type="double" value="18000" name="maxValue"/>
                      <Option type="double" value="1.5" name="minSize"/>
                      <Option type="double" value="2" name="minValue"/>
                      <Option type="double" value="0" name="nullSize"/>
                      <Option type="int" value="2" name="scaleType"/>
                    </Option>
                    <Option type="int" value="1" name="t"/>
                  </Option>
                  <Option type="int" value="2" name="type"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
    <data-defined-properties>
      <Option type="Map">
        <Option type="QString" value="" name="name"/>
        <Option name="properties"/>
        <Option type="QString" value="collection" name="type"/>
      </Option>
    </data-defined-properties>
  </renderer-v2>
  <selection mode="Default">
    <selectionColor invalid="1"/>
    <selectionSymbol>
      <symbol type="marker" frame_rate="10" name="" is_animated="0" alpha="1" clip_to_extent="1" force_rhr="0">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleMarker" id="{b0f68035-9d2a-4303-963b-4c9f30ff9d17}" enabled="1" locked="0" pass="0">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="255,0,0,255,rgb:1,0,0,1" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="circle" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="35,35,35,255,rgb:0.13725490196078433,0.13725490196078433,0.13725490196078433,1" name="outline_color"/>
            <Option type="QString" value="solid" name="outline_style"/>
            <Option type="QString" value="0" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="2" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </selectionSymbol>
  </selection>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <referencedLayers/>
  <fieldConfiguration>
    <field name="id" configurationFlags="NoFlag">
      <editWidget type="Range">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="nom_rue" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="num_clean" configurationFlags="NoFlag">
      <editWidget type="Range">
        <config>
          <Option type="Map">
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="int" value="2147483647" name="Max"/>
            <Option type="int" value="-2147483648" name="Min"/>
            <Option type="int" value="0" name="Precision"/>
            <Option type="int" value="1" name="Step"/>
            <Option type="QString" value="SpinBox" name="Style"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="lettre_clean" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="commune" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="annee" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="comment" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="true" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="identif" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="annee_ref" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="rue_id" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="commune_loc" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="tmstmp" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="muni_short_in" configurationFlags="NoFlag">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="false" name="AllowNull"/>
            <Option type="invalid" name="FilterExpression"/>
            <Option type="QString" value="muni_short" name="Key"/>
            <Option type="QString" value="muninames_fr_37f014f5_a694_41cd_930d_90f34fa6d0d6" name="Layer"/>
            <Option type="QString" value="Noms français" name="LayerName"/>
            <Option type="QString" value="postgres" name="LayerProviderName"/>
            <Option type="QString" value="dbname='micmarc' host=164.15.254.106 port=5432 authcfg=0q67e3n key='id' checkPrimaryKeyUnicity='1' table=&quot;data&quot;.&quot;muninames_fr&quot; sql=" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="nom" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="muni_short_out" configurationFlags="NoFlag">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="invalid" name="FilterExpression"/>
            <Option type="QString" value="muni_short" name="Key"/>
            <Option type="QString" value="muninames_fr_37f014f5_a694_41cd_930d_90f34fa6d0d6" name="Layer"/>
            <Option type="QString" value="Noms français" name="LayerName"/>
            <Option type="QString" value="postgres" name="LayerProviderName"/>
            <Option type="QString" value="dbname='micmarc' host=164.15.254.106 port=5432 authcfg=0q67e3n key='id' checkPrimaryKeyUnicity='1' table=&quot;data&quot;.&quot;muninames_fr&quot; sql=" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="nom" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="found_street" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="dist_muni" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="modif_nom_rue" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="modif_num" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="modif_muni" configurationFlags="NoFlag">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="invalid" name="Description"/>
            <Option type="invalid" name="FilterExpression"/>
            <Option type="QString" value="muni_short" name="Key"/>
            <Option type="QString" value="communes_1894_valid_dessour_b2965696_84bf_4e99_8fa6_27c569bb97b4" name="Layer"/>
            <Option type="QString" value="Communes en 1894" name="LayerName"/>
            <Option type="QString" value="postgres" name="LayerProviderName"/>
            <Option type="QString" value="dbname='micmarc' host=164.15.254.106 port=5432 key='id2' checkPrimaryKeyUnicity='0' table=&quot;couches&quot;.&quot;communes_1894_valid_dessour&quot; (geom)" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="true" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="commune_fr" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="modif_année" configurationFlags="NoFlag">
      <editWidget type="Range">
        <config>
          <Option type="Map">
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="int" value="2030" name="Max"/>
            <Option type="int" value="1600" name="Min"/>
            <Option type="int" value="0" name="Precision"/>
            <Option type="int" value="1" name="Step"/>
            <Option type="QString" value="SpinBox" name="Style"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="detect_rue" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="detect_num" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="det_epoque" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" name="" index="0"/>
    <alias field="nom_rue" name="Rue" index="1"/>
    <alias field="num_clean" name="Numéro" index="2"/>
    <alias field="lettre_clean" name="Lettre" index="3"/>
    <alias field="commune" name="Commune" index="4"/>
    <alias field="annee" name="Année fournie" index="5"/>
    <alias field="comment" name="Commentaire fourni" index="6"/>
    <alias field="identif" name="Code de correspondance" index="7"/>
    <alias field="annee_ref" name="Année de référence utilisée" index="8"/>
    <alias field="rue_id" name="Code de la rue trouvée" index="9"/>
    <alias field="commune_loc" name="Commune obtenue" index="10"/>
    <alias field="tmstmp" name="" index="11"/>
    <alias field="muni_short_in" name="Commune soumise" index="12"/>
    <alias field="muni_short_out" name="Commune de localisation" index="13"/>
    <alias field="found_street" name="Rue trouvée" index="14"/>
    <alias field="dist_muni" name="" index="15"/>
    <alias field="modif_nom_rue" name="Nouveau nom de rue ?" index="16"/>
    <alias field="modif_num" name="Nouveau numéro ?" index="17"/>
    <alias field="modif_muni" name="Nouvelle commune ?" index="18"/>
    <alias field="modif_année" name="Autre année ?" index="19"/>
    <alias field="detect_rue" name="Reconnaissance de la rue :" index="20"/>
    <alias field="detect_num" name="Localisation dans la rue :" index="21"/>
    <alias field="det_epoque" name="Correspondance temporelle (si recherche historique) :" index="22"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="Duplicate" field="nom_rue"/>
    <policy policy="Duplicate" field="num_clean"/>
    <policy policy="Duplicate" field="lettre_clean"/>
    <policy policy="Duplicate" field="commune"/>
    <policy policy="Duplicate" field="annee"/>
    <policy policy="DefaultValue" field="comment"/>
    <policy policy="DefaultValue" field="identif"/>
    <policy policy="Duplicate" field="annee_ref"/>
    <policy policy="Duplicate" field="rue_id"/>
    <policy policy="Duplicate" field="commune_loc"/>
    <policy policy="Duplicate" field="tmstmp"/>
    <policy policy="Duplicate" field="muni_short_in"/>
    <policy policy="Duplicate" field="muni_short_out"/>
    <policy policy="Duplicate" field="found_street"/>
    <policy policy="Duplicate" field="dist_muni"/>
    <policy policy="DefaultValue" field="modif_nom_rue"/>
    <policy policy="DefaultValue" field="modif_num"/>
    <policy policy="DefaultValue" field="modif_muni"/>
    <policy policy="DefaultValue" field="modif_année"/>
    <policy policy="DefaultValue" field="detect_rue"/>
    <policy policy="DefaultValue" field="detect_num"/>
    <policy policy="DefaultValue" field="det_epoque"/>
  </splitPolicies>
  <duplicatePolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="Duplicate" field="nom_rue"/>
    <policy policy="Duplicate" field="num_clean"/>
    <policy policy="Duplicate" field="lettre_clean"/>
    <policy policy="Duplicate" field="commune"/>
    <policy policy="Duplicate" field="annee"/>
    <policy policy="Duplicate" field="comment"/>
    <policy policy="Duplicate" field="identif"/>
    <policy policy="Duplicate" field="annee_ref"/>
    <policy policy="Duplicate" field="rue_id"/>
    <policy policy="Duplicate" field="commune_loc"/>
    <policy policy="Duplicate" field="tmstmp"/>
    <policy policy="Duplicate" field="muni_short_in"/>
    <policy policy="Duplicate" field="muni_short_out"/>
    <policy policy="Duplicate" field="found_street"/>
    <policy policy="Duplicate" field="dist_muni"/>
    <policy policy="Duplicate" field="modif_nom_rue"/>
    <policy policy="Duplicate" field="modif_num"/>
    <policy policy="Duplicate" field="modif_muni"/>
    <policy policy="Duplicate" field="modif_année"/>
    <policy policy="Duplicate" field="detect_rue"/>
    <policy policy="Duplicate" field="detect_num"/>
    <policy policy="Duplicate" field="det_epoque"/>
  </duplicatePolicies>
  <defaults>
    <default field="id" applyOnUpdate="0" expression=""/>
    <default field="nom_rue" applyOnUpdate="0" expression=""/>
    <default field="num_clean" applyOnUpdate="0" expression=""/>
    <default field="lettre_clean" applyOnUpdate="0" expression=""/>
    <default field="commune" applyOnUpdate="0" expression=""/>
    <default field="annee" applyOnUpdate="0" expression=""/>
    <default field="comment" applyOnUpdate="0" expression=""/>
    <default field="identif" applyOnUpdate="0" expression=""/>
    <default field="annee_ref" applyOnUpdate="0" expression=""/>
    <default field="rue_id" applyOnUpdate="0" expression=""/>
    <default field="commune_loc" applyOnUpdate="0" expression=""/>
    <default field="tmstmp" applyOnUpdate="0" expression=""/>
    <default field="muni_short_in" applyOnUpdate="0" expression=""/>
    <default field="muni_short_out" applyOnUpdate="0" expression=""/>
    <default field="found_street" applyOnUpdate="0" expression=""/>
    <default field="dist_muni" applyOnUpdate="0" expression=""/>
    <default field="modif_nom_rue" applyOnUpdate="0" expression="&quot;nom_rue&quot;"/>
    <default field="modif_num" applyOnUpdate="0" expression=""/>
    <default field="modif_muni" applyOnUpdate="0" expression=""/>
    <default field="modif_année" applyOnUpdate="0" expression=""/>
    <default field="detect_rue" applyOnUpdate="0" expression=""/>
    <default field="detect_num" applyOnUpdate="0" expression=""/>
    <default field="det_epoque" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" field="id" constraints="3" unique_strength="1" notnull_strength="1"/>
    <constraint exp_strength="0" field="nom_rue" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="num_clean" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="lettre_clean" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="commune" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="annee" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="comment" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="identif" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="annee_ref" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="rue_id" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="commune_loc" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="tmstmp" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="muni_short_in" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="muni_short_out" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="found_street" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="dist_muni" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="modif_nom_rue" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="modif_num" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="modif_muni" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="modif_année" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="detect_rue" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="detect_num" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="det_epoque" constraints="0" unique_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="id"/>
    <constraint desc="" exp="" field="nom_rue"/>
    <constraint desc="" exp="" field="num_clean"/>
    <constraint desc="" exp="" field="lettre_clean"/>
    <constraint desc="" exp="" field="commune"/>
    <constraint desc="" exp="" field="annee"/>
    <constraint desc="" exp="" field="comment"/>
    <constraint desc="" exp="" field="identif"/>
    <constraint desc="" exp="" field="annee_ref"/>
    <constraint desc="" exp="" field="rue_id"/>
    <constraint desc="" exp="" field="commune_loc"/>
    <constraint desc="" exp="" field="tmstmp"/>
    <constraint desc="" exp="" field="muni_short_in"/>
    <constraint desc="" exp="" field="muni_short_out"/>
    <constraint desc="" exp="" field="found_street"/>
    <constraint desc="" exp="" field="dist_muni"/>
    <constraint desc="" exp="" field="modif_nom_rue"/>
    <constraint desc="" exp="" field="modif_num"/>
    <constraint desc="" exp="" field="modif_muni"/>
    <constraint desc="" exp="" field="modif_année"/>
    <constraint desc="" exp="" field="detect_rue"/>
    <constraint desc="" exp="" field="detect_num"/>
    <constraint desc="" exp="" field="det_epoque"/>
  </constraintExpressions>
  <expressionfields>
    <field type="10" subType="0" length="0" precision="0" name="detect_rue" comment="" typeName="string" expression="CASE WHEN substr( &quot;identif&quot; , 1, 1) = 'A'  AND substr( &quot;identif&quot; , 5, 1) IN ('0', '1') THEN 'rue reconnue par identité,  sans recours à la commune'&#xa;&#x9;WHEN substr( &quot;identif&quot; , 1, 1) = 'A'  AND substr( &quot;identif&quot; , 5, 1) = '2' THEN 'rue reconnue par identité, avec recours à la commune'&#xa;&#x9;WHEN substr( &quot;identif&quot; , 1, 1) = 'A'  AND substr( &quot;identif&quot; , 5, 1) = '3' THEN 'rue reconnue par identité à partir de noms simplifiés, avec recours à la commune'&#xa;&#x9;WHEN substr( &quot;identif&quot; , 1, 1) = 'B'  AND substr( &quot;identif&quot; , 5, 1) = '0' THEN 'rue reconnue par similarité, sans recours à la commune'&#xa;&#x9;WHEN substr( &quot;identif&quot; , 1, 1) = 'B'  AND substr( &quot;identif&quot; , 5, 1) = '1' THEN 'rue reconnue par similarité sur base de noms alternatifs,  avec recours à la commune'&#xa;&#x9;WHEN substr( &quot;identif&quot; , 1, 1) = 'B'  AND substr( &quot;identif&quot; , 5, 1) = '2' THEN 'rue reconnue par similarité, sur base de noms alternatifs et avec recours à la commune'&#xa;&#x9;WHEN substr( &quot;identif&quot; , 1, 1) = 'B'  AND substr( &quot;identif&quot; , 5, 1) = '3' THEN 'rue reconnue par similarité à partir de noms simplifiés, avec recours à la commune'&#xa;&#x9;WHEN substr( &quot;identif&quot; , 1, 1) = 'B'  AND substr( &quot;identif&quot; , 5, 1) = '4' THEN 'rue reconnue par similarité de nom mais avec type de voirie différent, et recours à la commune'&#xa;&#x9;WHEN substr( &quot;identif&quot; , 1, 1) = 'C'  THEN 'rue reconnue par simplification outrancière, avec recours à la commune'&#xa;&#x9;END"/>
    <field type="10" subType="0" length="0" precision="0" name="detect_num" comment="" typeName="string" expression="CASE WHEN substr( &quot;identif&quot; , 2, 1) = 'U' AND substr( &quot;identif&quot; , 6, 1) = '0' THEN 'batiment trouvé précisément'&#xa;&#x9;WHEN substr( &quot;identif&quot; , 2, 1) = 'A' AND substr( &quot;identif&quot; , 6, 1) = '0' THEN 'localisation par interpolation,  respect du coté'&#xa;&#x9;WHEN substr( &quot;identif&quot; , 2, 1) = 'A' AND substr( &quot;identif&quot; , 6, 1) = '1' THEN 'localisation par interpolation, coté de la rue ignoré' &#xa;&#x9;WHEN substr( &quot;identif&quot; , 2, 1) = 'B' AND substr( &quot;identif&quot; , 6, 1) = '1' THEN 'localisation au centroide sans numéro mais respect de la commune'&#xa;&#x9;WHEN substr( &quot;identif&quot; , 2, 1) = 'B' AND substr( &quot;identif&quot; , 6, 1) = '2' THEN 'localisation au centroide sans numéro, commune ignorée'&#xa;&#x9;END"/>
    <field type="10" subType="0" length="0" precision="0" name="det_epoque" comment="" typeName="string" expression="CASE WHEN abs (&quot;annee&quot;  -  &quot;annee_ref&quot;) &lt; 20 THEN 'bonne correspondance temporelle'&#xa;&#x9;WHEN abs (&quot;annee&quot;  -  &quot;annee_ref&quot;) >= 20  AND abs (&quot;annee&quot;  -  &quot;annee_ref&quot;) &lt; 50 THEN 'faible correspondance temporelle'&#xa;&#x9;WHEN abs (&quot;annee&quot;  -  &quot;annee_ref&quot;) >= 50 THEN 'Pas de correspondance temporelle' &#xa;&#x9;END"/>
  </expressionfields>
  <attributetableconfig sortOrder="1" sortExpression="&quot;identif&quot;" actionWidgetStyle="buttonList">
    <columns>
      <column type="field" hidden="0" name="id" width="-1"/>
      <column type="field" hidden="0" name="nom_rue" width="213"/>
      <column type="field" hidden="0" name="num_clean" width="-1"/>
      <column type="field" hidden="0" name="lettre_clean" width="-1"/>
      <column type="field" hidden="0" name="commune" width="-1"/>
      <column type="field" hidden="0" name="annee" width="-1"/>
      <column type="field" hidden="0" name="comment" width="228"/>
      <column type="field" hidden="0" name="identif" width="-1"/>
      <column type="field" hidden="0" name="annee_ref" width="-1"/>
      <column type="field" hidden="0" name="rue_id" width="-1"/>
      <column type="field" hidden="0" name="commune_loc" width="-1"/>
      <column type="field" hidden="0" name="tmstmp" width="-1"/>
      <column type="actions" hidden="0" width="-1"/>
      <column type="field" hidden="0" name="muni_short_in" width="-1"/>
      <column type="field" hidden="0" name="muni_short_out" width="-1"/>
      <column type="field" hidden="0" name="found_street" width="-1"/>
      <column type="field" hidden="0" name="detect_rue" width="-1"/>
      <column type="field" hidden="0" name="detect_num" width="-1"/>
      <column type="field" hidden="0" name="det_epoque" width="-1"/>
      <column type="field" hidden="0" name="modif_nom_rue" width="-1"/>
      <column type="field" hidden="0" name="modif_num" width="-1"/>
      <column type="field" hidden="0" name="modif_muni" width="-1"/>
      <column type="field" hidden="0" name="modif_année" width="-1"/>
      <column type="field" hidden="0" name="dist_muni" width="-1"/>
    </columns>
  </attributetableconfig>
  <conditionalstyles>
    <rowstyles/>
    <fieldstyles/>
  </conditionalstyles>
  <storedexpressions/>
  <editform tolerant="1">/Volumes/DataHD/Box Sync/Box Sync/_Default Sync Folder/micmarc/carto/bhigis</editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath>/Volumes/DataHD/Box Sync/Box Sync/_Default Sync Folder/micmarc/carto/bhigis</editforminitfilepath>
  <editforminitcode><![CDATA[# -*- coding: utf-8 -*-
"""
Les formulaires QGIS peuvent avoir une fonction Python qui sera appelée à l'ouverture du formulaire.

Utilisez cette fonction pour ajouter plus de fonctionnalités à vos formulaires.

Entrez le nom de la fonction dans le champ "Fonction d'initialisation Python".
Voici un exemple à suivre:
"""
from qgis.PyQt.QtWidgets import QWidget

def my_form_open(dialog, layer, feature):
    geom = feature.geometry()
    control = dialog.findChild(QWidget, "MyLineEdit")

]]></editforminitcode>
  <featformsuppress>0</featformsuppress>
  <editorlayout>tablayout</editorlayout>
  <attributeEditorForm>
    <labelStyle labelColor="" overrideLabelFont="0" overrideLabelColor="0">
      <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
    </labelStyle>
    <attributeEditorContainer type="Tab" collapsedExpressionEnabled="0" columnCount="0" groupBox="0" showLabel="1" visibilityExpressionEnabled="0" name="Localisation" collapsedExpression="" verticalStretch="0" visibilityExpression="" horizontalStretch="0" collapsed="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
      </labelStyle>
      <attributeEditorContainer type="GroupBox" collapsedExpressionEnabled="0" columnCount="1" groupBox="1" showLabel="1" visibilityExpressionEnabled="0" name="Recherche" collapsedExpression="" verticalStretch="0" visibilityExpression="" horizontalStretch="0" collapsed="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
        </labelStyle>
        <attributeEditorField showLabel="1" name="nom_rue" verticalStretch="0" index="1" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" name="num_clean" verticalStretch="0" index="2" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description="Academy Engraved LET,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" name="lettre_clean" verticalStretch="0" index="3" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" name="commune" verticalStretch="0" index="4" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description="Academy Engraved LET,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" name="annee" verticalStretch="0" index="5" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
      </attributeEditorContainer>
      <attributeEditorContainer type="GroupBox" collapsedExpressionEnabled="0" columnCount="1" groupBox="1" showLabel="1" visibilityExpressionEnabled="0" name="Résultat" collapsedExpression="" verticalStretch="0" visibilityExpression="" horizontalStretch="0" collapsed="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
        </labelStyle>
        <attributeEditorField showLabel="1" name="found_street" verticalStretch="0" index="14" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" name="muni_short_out" verticalStretch="0" index="13" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" name="annee_ref" verticalStretch="0" index="8" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
      </attributeEditorContainer>
      <attributeEditorContainer type="GroupBox" collapsedExpressionEnabled="0" columnCount="1" groupBox="1" showLabel="1" visibilityExpressionEnabled="1" name="Description" collapsedExpression="" verticalStretch="0" visibilityExpression=" &quot;comment&quot; is not null" horizontalStretch="0" collapsed="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description="Academy Engraved LET,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
        </labelStyle>
        <attributeEditorField showLabel="1" name="comment" verticalStretch="0" index="6" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description="Academy Engraved LET,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
      </attributeEditorContainer>
    </attributeEditorContainer>
    <attributeEditorContainer type="Tab" collapsedExpressionEnabled="0" columnCount="0" groupBox="0" showLabel="1" visibilityExpressionEnabled="0" name="Paramètres" collapsedExpression="" verticalStretch="0" visibilityExpression="" horizontalStretch="0" collapsed="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" name="id" verticalStretch="0" index="0" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" name="rue_id" verticalStretch="0" index="9" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" name="annee_ref" verticalStretch="0" index="8" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" name="tmstmp" verticalStretch="0" index="11" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" name="muni_short_in" verticalStretch="0" index="12" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" name="muni_short_out" verticalStretch="0" index="13" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorContainer type="GroupBox" collapsedExpressionEnabled="0" columnCount="1" groupBox="1" showLabel="1" visibilityExpressionEnabled="0" name="identification" collapsedExpression="" verticalStretch="0" visibilityExpression="" horizontalStretch="0" collapsed="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
        </labelStyle>
        <attributeEditorField showLabel="1" name="identif" verticalStretch="0" index="7" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" name="detect_rue" verticalStretch="0" index="20" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" name="detect_num" verticalStretch="0" index="21" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" name="det_epoque" verticalStretch="0" index="22" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
      </attributeEditorContainer>
    </attributeEditorContainer>
    <attributeEditorContainer type="Tab" collapsedExpressionEnabled="0" columnCount="1" backgroundColor="#ede7ef" groupBox="0" showLabel="1" visibilityExpressionEnabled="0" name="Modifier cette recherche" collapsedExpression="" verticalStretch="0" visibilityExpression="" horizontalStretch="0" collapsed="0">
      <labelStyle labelColor="197,22,27,255,rgb:0.77254901960784317,0.08627450980392157,0.10588235294117647,1" overrideLabelFont="0" overrideLabelColor="1">
        <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
      </labelStyle>
      <attributeEditorContainer type="GroupBox" collapsedExpressionEnabled="0" columnCount="1" groupBox="1" showLabel="1" visibilityExpressionEnabled="0" name="Vous pouvez ici modifier l'adresse soumise initialement" collapsedExpression="" verticalStretch="0" visibilityExpression="" horizontalStretch="0" collapsed="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
        </labelStyle>
        <attributeEditorField showLabel="1" name="modif_nom_rue" verticalStretch="0" index="16" horizontalStretch="0">
          <labelStyle labelColor="239,223,238,255,rgb:0.93725490196078431,0.87450980392156863,0.93333333333333335,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" name="modif_num" verticalStretch="0" index="17" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" name="modif_muni" verticalStretch="0" index="18" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
        <attributeEditorField showLabel="1" name="modif_année" verticalStretch="0" index="19" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorField>
      </attributeEditorContainer>
    </attributeEditorContainer>
    <attributeEditorContainer type="Tab" collapsedExpressionEnabled="0" columnCount="1" backgroundColor="#ffffff" groupBox="0" showLabel="1" visibilityExpressionEnabled="0" name="Charger de nouvelles données" collapsedExpression="" verticalStretch="0" visibilityExpression="" horizontalStretch="0" collapsed="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
      </labelStyle>
      <attributeEditorContainer type="GroupBox" collapsedExpressionEnabled="0" columnCount="1" backgroundColor="#f8e5d7" groupBox="1" showLabel="1" visibilityExpressionEnabled="0" name="          Attention, cette opération supprimera tous vos résultats actuels" collapsedExpression="" verticalStretch="0" visibilityExpression="" horizontalStretch="0" collapsed="0">
        <labelStyle labelColor="197,22,27,255,rgb:0.77254901960784317,0.08627450980392157,0.10588235294117647,1" overrideLabelFont="0" overrideLabelColor="1">
          <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
        </labelStyle>
        <attributeEditorAction ActionUUID="{0c7d774c-9a0b-4286-ab70-8242860dbc0f}" showLabel="1" name="{0c7d774c-9a0b-4286-ab70-8242860dbc0f}" verticalStretch="0" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorAction>
      </attributeEditorContainer>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="annee"/>
    <field editable="0" name="annee_ref"/>
    <field editable="1" name="comment"/>
    <field editable="1" name="commune"/>
    <field editable="0" name="commune_loc"/>
    <field editable="0" name="det_epoque"/>
    <field editable="0" name="detect_epoque"/>
    <field editable="0" name="detect_num"/>
    <field editable="0" name="detect_rue"/>
    <field editable="1" name="dist_muni"/>
    <field editable="0" name="found_street"/>
    <field editable="1" name="id"/>
    <field editable="1" name="identif"/>
    <field editable="1" name="lettre_clean"/>
    <field editable="1" name="modif_année"/>
    <field editable="1" name="modif_muni"/>
    <field editable="1" name="modif_nom_rue"/>
    <field editable="1" name="modif_num"/>
    <field editable="0" name="muni_short_in"/>
    <field editable="0" name="muni_short_out"/>
    <field editable="1" name="nom_rue"/>
    <field editable="1" name="num_clean"/>
    <field editable="1" name="rue_id"/>
    <field editable="1" name="tmstmp"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="annee"/>
    <field labelOnTop="0" name="annee_ref"/>
    <field labelOnTop="0" name="comment"/>
    <field labelOnTop="0" name="commune"/>
    <field labelOnTop="1" name="commune_loc"/>
    <field labelOnTop="0" name="det_epoque"/>
    <field labelOnTop="1" name="detect_epoque"/>
    <field labelOnTop="0" name="detect_num"/>
    <field labelOnTop="0" name="detect_rue"/>
    <field labelOnTop="0" name="dist_muni"/>
    <field labelOnTop="0" name="found_street"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="identif"/>
    <field labelOnTop="0" name="lettre_clean"/>
    <field labelOnTop="0" name="modif_année"/>
    <field labelOnTop="0" name="modif_muni"/>
    <field labelOnTop="0" name="modif_nom_rue"/>
    <field labelOnTop="0" name="modif_num"/>
    <field labelOnTop="0" name="muni_short_in"/>
    <field labelOnTop="0" name="muni_short_out"/>
    <field labelOnTop="0" name="nom_rue"/>
    <field labelOnTop="0" name="num_clean"/>
    <field labelOnTop="0" name="rue_id"/>
    <field labelOnTop="0" name="tmstmp"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="annee"/>
    <field reuseLastValue="0" name="annee_ref"/>
    <field reuseLastValue="0" name="comment"/>
    <field reuseLastValue="0" name="commune"/>
    <field reuseLastValue="0" name="commune_loc"/>
    <field reuseLastValue="0" name="det_epoque"/>
    <field reuseLastValue="0" name="detect_epoque"/>
    <field reuseLastValue="0" name="detect_num"/>
    <field reuseLastValue="0" name="detect_rue"/>
    <field reuseLastValue="0" name="dist_muni"/>
    <field reuseLastValue="0" name="found_street"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="identif"/>
    <field reuseLastValue="0" name="lettre_clean"/>
    <field reuseLastValue="0" name="modif_année"/>
    <field reuseLastValue="0" name="modif_muni"/>
    <field reuseLastValue="0" name="modif_nom_rue"/>
    <field reuseLastValue="0" name="modif_num"/>
    <field reuseLastValue="0" name="muni_short_in"/>
    <field reuseLastValue="0" name="muni_short_out"/>
    <field reuseLastValue="0" name="nom_rue"/>
    <field reuseLastValue="0" name="num_clean"/>
    <field reuseLastValue="0" name="rue_id"/>
    <field reuseLastValue="0" name="tmstmp"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets>
    <widget name="données_annee">
      <config/>
    </widget>
    <widget name="données_comment">
      <config/>
    </widget>
    <widget name="données_commune">
      <config/>
    </widget>
    <widget name="données_nom_rue">
      <config/>
    </widget>
    <widget name="données_numero">
      <config/>
    </widget>
    <widget name="données_réf_000 Date fin incertaine">
      <config/>
    </widget>
    <widget name="données_réf_Chercheur - encodage des donnes">
      <config/>
    </widget>
    <widget name="données_réf_Commentaires">
      <config/>
    </widget>
    <widget name="données_réf_Date dbut activit">
      <config/>
    </widget>
    <widget name="données_réf_Date dbut incertaine">
      <config/>
    </widget>
    <widget name="données_réf_Date fin activit">
      <config/>
    </widget>
    <widget name="données_réf_Dnomination">
      <config/>
    </widget>
    <widget name="données_réf_Fonction premire de l'tablissment">
      <config/>
    </widget>
    <widget name="données_réf_Fonction secondaire 1">
      <config/>
    </widget>
    <widget name="données_réf_Fonction secondaire 2">
      <config/>
    </widget>
    <widget name="données_réf_Jauge">
      <config/>
    </widget>
  </widgets>
  <layerGeometryType>0</layerGeometryType>
</qgis>
