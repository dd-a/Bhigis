<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.40.5-Bratislava" styleCategories="Symbology|Fields|Forms|AttributeTable|Relations">
  <referencedLayers/>
  <fieldConfiguration>
    <field name="id" configurationFlags="NoFlag">
      <editWidget type="Range">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="missing_street" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="nom_signif" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option/>
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
    <field name="selected_street" configurationFlags="NoFlag">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;nom_rue&quot; = current_value( 'missing_street' ) " name="FilterExpression"/>
            <Option type="QString" value="id_sugg" name="Key"/>
            <Option type="QString" value="suggestions_1cb9e5c2_7ddb_49ef_b546_e6ed5317798d" name="Layer"/>
            <Option type="QString" value="Suggestions" name="LayerName"/>
            <Option type="QString" value="postgres" name="LayerProviderName"/>
            <Option type="QString" value="dbname='micmarc' host=164.15.254.106 port=5432 key='tid' checkPrimaryKeyUnicity='0' table=&quot;didier&quot;.&quot;suggestions&quot; sql=" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="false" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="rue_db" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="alternative_name" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="IsMultiline"/>
            <Option type="bool" value="false" name="UseHtml"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="rue_yr" configurationFlags="NoFlag">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="alter_muni" configurationFlags="NoFlag">
      <editWidget type="ValueRelation">
        <config>
          <Option type="Map">
            <Option type="bool" value="false" name="AllowMulti"/>
            <Option type="bool" value="true" name="AllowNull"/>
            <Option type="QString" value="&quot;id&quot; = current_value( 'id' ) " name="FilterExpression"/>
            <Option type="QString" value="alter_muni" name="Key"/>
            <Option type="QString" value="suggest_muni_edc27db0_cec8_4f5a_a43b_26b0b251adee" name="Layer"/>
            <Option type="QString" value="Communes alternatives" name="LayerName"/>
            <Option type="QString" value="postgres" name="LayerProviderName"/>
            <Option type="QString" value="dbname='micmarc' host=164.15.254.106 port=5432 authcfg=0q67e3n key='tid' checkPrimaryKeyUnicity='1' table=&quot;didier&quot;.&quot;suggest_muni&quot;" name="LayerSource"/>
            <Option type="int" value="1" name="NofColumns"/>
            <Option type="bool" value="true" name="OrderByValue"/>
            <Option type="bool" value="false" name="UseCompleter"/>
            <Option type="QString" value="alter_name" name="Value"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias field="id" name="" index="0"/>
    <alias field="missing_street" name="Rue non trouvée" index="1"/>
    <alias field="nom_signif" name="" index="2"/>
    <alias field="annee" name="Année" index="3"/>
    <alias field="selected_street" name="Choisissez ici un autre nom de rue :" index="4"/>
    <alias field="alternative_name" name="Ou alors proposez-en un manuellement ci-dessous :" index="5"/>
    <alias field="rue_yr" name="" index="6"/>
    <alias field="alter_muni" name="Modifier la commune" index="7"/>
  </aliases>
  <splitPolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="Duplicate" field="missing_street"/>
    <policy policy="Duplicate" field="nom_signif"/>
    <policy policy="Duplicate" field="annee"/>
    <policy policy="Duplicate" field="selected_street"/>
    <policy policy="Duplicate" field="alternative_name"/>
    <policy policy="Duplicate" field="rue_yr"/>
    <policy policy="Duplicate" field="alter_muni"/>
  </splitPolicies>
  <duplicatePolicies>
    <policy policy="Duplicate" field="id"/>
    <policy policy="Duplicate" field="missing_street"/>
    <policy policy="Duplicate" field="nom_signif"/>
    <policy policy="Duplicate" field="annee"/>
    <policy policy="Duplicate" field="selected_street"/>
    <policy policy="Duplicate" field="alternative_name"/>
    <policy policy="Duplicate" field="rue_yr"/>
    <policy policy="Duplicate" field="alter_muni"/>
  </duplicatePolicies>
  <defaults>
    <default field="id" applyOnUpdate="0" expression=""/>
    <default field="missing_street" applyOnUpdate="0" expression=""/>
    <default field="nom_signif" applyOnUpdate="0" expression=""/>
    <default field="annee" applyOnUpdate="0" expression=""/>
    <default field="selected_street" applyOnUpdate="0" expression=""/>
    <default field="alternative_name" applyOnUpdate="0" expression=""/>
    <default field="rue_yr" applyOnUpdate="0" expression=""/>
    <default field="alter_muni" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" field="id" constraints="3" unique_strength="1" notnull_strength="1"/>
    <constraint exp_strength="0" field="missing_street" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="nom_signif" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="annee" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="selected_street" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="alternative_name" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="rue_yr" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="alter_muni" constraints="0" unique_strength="0" notnull_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="id"/>
    <constraint desc="" exp="" field="missing_street"/>
    <constraint desc="" exp="" field="nom_signif"/>
    <constraint desc="" exp="" field="annee"/>
    <constraint desc="" exp="" field="selected_street"/>
    <constraint desc="" exp="" field="alternative_name"/>
    <constraint desc="" exp="" field="rue_yr"/>
    <constraint desc="" exp="" field="alter_muni"/>
  </constraintExpressions>
  <expressionfields/>
  <attributetableconfig sortOrder="1" sortExpression="&quot;missing_street&quot;" actionWidgetStyle="buttonList">
    <columns>
      <column type="field" hidden="0" name="id" width="-1"/>
      <column type="field" hidden="0" name="missing_street" width="290"/>
      <column type="field" hidden="0" name="annee" width="-1"/>
      <column type="field" hidden="0" name="selected_street" width="244"/>
      <column type="actions" hidden="0" width="-1"/>
      <column type="field" hidden="0" name="nom_signif" width="-1"/>
      <column type="field" hidden="0" name="alternative_name" width="-1"/>
      <column type="field" hidden="0" name="rue_yr" width="207"/>
      <column type="field" hidden="0" name="alter_muni" width="-1"/>
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
    <attributeEditorContainer type="Tab" collapsedExpressionEnabled="0" columnCount="1" groupBox="0" showLabel="1" visibilityExpressionEnabled="0" name="Nom non reconnu" collapsedExpression="" verticalStretch="0" visibilityExpression="" horizontalStretch="0" collapsed="0">
      <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
        <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
      </labelStyle>
      <attributeEditorField showLabel="1" name="missing_street" verticalStretch="0" index="1" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorField showLabel="1" name="annee" verticalStretch="0" index="3" horizontalStretch="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
        </labelStyle>
      </attributeEditorField>
      <attributeEditorContainer type="GroupBox" collapsedExpressionEnabled="0" columnCount="1" groupBox="1" showLabel="1" visibilityExpressionEnabled="0" name="Substitution" collapsedExpression="" verticalStretch="0" visibilityExpression="" horizontalStretch="0" collapsed="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
        </labelStyle>
        <attributeEditorContainer type="GroupBox" collapsedExpressionEnabled="0" columnCount="1" groupBox="1" showLabel="1" visibilityExpressionEnabled="0" name="Rue" collapsedExpression="" verticalStretch="0" visibilityExpression="" horizontalStretch="0" collapsed="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
          <attributeEditorField showLabel="1" name="selected_street" verticalStretch="0" index="4" horizontalStretch="0">
            <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
              <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
            </labelStyle>
          </attributeEditorField>
          <attributeEditorField showLabel="1" name="alternative_name" verticalStretch="0" index="5" horizontalStretch="0">
            <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
              <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
            </labelStyle>
          </attributeEditorField>
        </attributeEditorContainer>
        <attributeEditorContainer type="GroupBox" collapsedExpressionEnabled="0" columnCount="1" groupBox="1" showLabel="1" visibilityExpressionEnabled="0" name="Commune" collapsedExpression="" verticalStretch="0" visibilityExpression="&quot;id&quot; = current_value( 'id' ) AND &quot;alter_muni&quot; is  null" horizontalStretch="0" collapsed="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
          <attributeEditorField showLabel="1" name="alter_muni" verticalStretch="0" index="7" horizontalStretch="0">
            <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
              <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
            </labelStyle>
          </attributeEditorField>
        </attributeEditorContainer>
      </attributeEditorContainer>
      <attributeEditorContainer type="GroupBox" collapsedExpressionEnabled="0" columnCount="1" groupBox="1" showLabel="1" visibilityExpressionEnabled="0" name="Adresses correspondantes recherchées (sélectionner pour voir)" collapsedExpression="" verticalStretch="0" visibilityExpression="" horizontalStretch="0" collapsed="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description=".SF NS Text,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
        </labelStyle>
        <attributeEditorRelation relation="manquant_e_rue_yr_substituti_rue_yr" nmRelationId="" forceSuppressFormPopup="0" showLabel="1" relationWidgetTypeId="relation_editor" name="manquant_e_rue_yr_substituti_rue_yr" verticalStretch="0" horizontalStretch="0" label="">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description="Academy Engraved LET,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
          <editor_configuration type="Map">
            <Option type="bool" value="false" name="allow_add_child_feature_with_no_geometry"/>
            <Option type="QString" value="AllButtons" name="buttons"/>
            <Option type="bool" value="true" name="show_first_feature"/>
          </editor_configuration>
        </attributeEditorRelation>
      </attributeEditorContainer>
      <attributeEditorContainer type="GroupBox" collapsedExpressionEnabled="0" columnCount="1" backgroundColor="#f8e5d7" groupBox="1" showLabel="1" visibilityExpressionEnabled="0" name="       Soumettre les modifications" collapsedExpression="" verticalStretch="0" visibilityExpression="" horizontalStretch="0" collapsed="0">
        <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
          <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
        </labelStyle>
        <attributeEditorAction ActionUUID="{58db2b88-454d-467b-a0dd-ffa5f86518cc}" showLabel="1" name="{58db2b88-454d-467b-a0dd-ffa5f86518cc}" verticalStretch="0" horizontalStretch="0">
          <labelStyle labelColor="0,0,0,255,rgb:0,0,0,1" overrideLabelFont="0" overrideLabelColor="0">
            <labelFont bold="0" style="" description=".AppleSystemUIFont,13,-1,5,50,0,0,0,0,0" italic="0" strikethrough="0" underline="0"/>
          </labelStyle>
        </attributeEditorAction>
      </attributeEditorContainer>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="alter_muni"/>
    <field editable="1" name="alternative_name"/>
    <field editable="0" name="annee"/>
    <field editable="1" name="commune"/>
    <field editable="1" name="id"/>
    <field editable="1" name="missing_street"/>
    <field editable="1" name="nom_rue"/>
    <field editable="1" name="nom_signif"/>
    <field editable="1" name="numero"/>
    <field editable="1" name="raison"/>
    <field editable="1" name="rue_yr"/>
    <field editable="1" name="select_rue"/>
    <field editable="1" name="selected_street"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="1" name="alter_muni"/>
    <field labelOnTop="1" name="alternative_name"/>
    <field labelOnTop="0" name="annee"/>
    <field labelOnTop="0" name="commune"/>
    <field labelOnTop="0" name="id"/>
    <field labelOnTop="0" name="missing_street"/>
    <field labelOnTop="0" name="nom_rue"/>
    <field labelOnTop="0" name="nom_signif"/>
    <field labelOnTop="0" name="numero"/>
    <field labelOnTop="0" name="raison"/>
    <field labelOnTop="0" name="rue_yr"/>
    <field labelOnTop="1" name="select_rue"/>
    <field labelOnTop="1" name="selected_street"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="alter_muni"/>
    <field reuseLastValue="0" name="alternative_name"/>
    <field reuseLastValue="0" name="annee"/>
    <field reuseLastValue="0" name="id"/>
    <field reuseLastValue="0" name="missing_street"/>
    <field reuseLastValue="0" name="nom_signif"/>
    <field reuseLastValue="0" name="rue_yr"/>
    <field reuseLastValue="0" name="selected_street"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets>
    <widget name="manquant_e_nom_rue_substituti_missing_street">
      <config type="Map">
        <Option type="invalid" name="nm-rel"/>
      </config>
    </widget>
    <widget name="manquant_e_nom_rue_substituti_missing_street_1">
      <config type="Map">
        <Option type="invalid" name="nm-rel"/>
      </config>
    </widget>
    <widget name="manquant_e_rue_yr_substituti_rue_yr">
      <config type="Map">
        <Option type="invalid" name="nm-rel"/>
      </config>
    </widget>
  </widgets>
  <layerGeometryType>4</layerGeometryType>
</qgis>
