==========
Gen タスク
==========

.. contents:: 目次
   :depth: 3

Gen タスクは Doma-Gen の唯一のタスクです。

Gen タスクには、 ``EntityConfig``, ``DaoConfig``, ``SqlConfig``, ``SqlTestCaseConfig``
のデータ型をネストさせて使用できます。

トップレベルパラメータ
======================

Gen タスクのトップレベルのパラメータは次の通りです。

+--------------------------+-------------------------------------------------------------------------------+---------------------------------+------+
| パラメータ               | 説明                                                                          | デフォルト値                    | 必須 |
+==========================+===============================================================================+=================================+======+
| url                      | JDBC接続URLです。                                                             |                                 | YES  |
+--------------------------+-------------------------------------------------------------------------------+---------------------------------+------+
| user                     | JDBC接続ユーザーです。                                                        |                                 | YES  |
+--------------------------+-------------------------------------------------------------------------------+---------------------------------+------+
| password                 | JDBC接続パスワードです。                                                      |                                 | YES  |
+--------------------------+-------------------------------------------------------------------------------+---------------------------------+------+
| dialectName              | RDBMSの方言名です。                                                           |  ``url`` の値から推測されます。 |      |
|                          | 次の値が有効です。                                                            |                                 |      |
|                          | ``h2``, ``hsqldb``, ``mysql``, ``postgresql``,                                |                                 |      |
|                          | ``mssql``, ``oracle``,  ``db2``                                               |                                 |      |
+--------------------------+-------------------------------------------------------------------------------+---------------------------------+------+
| dialectClassName         | Doma の実行時に使われる RDBMS の方言です。コードに埋め込まれます。            |  ``url`` の値から推測されます。 |      |
+--------------------------+-------------------------------------------------------------------------------+---------------------------------+------+
| genDialectClassName      | コード生成に使用される RDBMS の方言です。                                     |  ``url`` の値から推測されます。 |      |
|                          | 指定するクラスは、Genタスクを実行するクラスパスに通されている必要があります。 |                                 |      |
+--------------------------+-------------------------------------------------------------------------------+---------------------------------+------+
| schemaName               | 対象とするテーブルが所属するスキーマ名です。                                  |                                 |      |
+--------------------------+-------------------------------------------------------------------------------+---------------------------------+------+
| tableNamePattern         | 対象とするテーブル名の正規表現です。大文字小文字は区別されません。            | .*                              |      |
+--------------------------+-------------------------------------------------------------------------------+---------------------------------+------+
| ignoredTableNamePattern  | 対象としないテーブル名の正規表現です。大文字小文字は区別されません。          | .*\$.*                          |      |
+--------------------------+-------------------------------------------------------------------------------+---------------------------------+------+
| tableTypes               | 対象とするテーブルの型です。                                                  | TABLE                           |      |
|                          | たとえば、テーブルに加えビューを対象にしたい場合、                            |                                 |      |
|                          | "TABLE, VIEW" と指定します。                                                  |                                 |      |
+--------------------------+-------------------------------------------------------------------------------+---------------------------------+------+
| versionColumnNamePattern | エンティティのプロパティに ``@Version``                                       |                                 |      |
|                          | を付与するカラム名の正規表現です。                                            |                                 |      |
|                          | 大文字小文字は区別されません。                                                |                                 |      |
+--------------------------+-------------------------------------------------------------------------------+---------------------------------+------+
| templateEncoding         | テンプレートファイルのエンコーディングです。                                  | UTF-8                           |      |
+--------------------------+-------------------------------------------------------------------------------+---------------------------------+------+
| templatePrimaryDir       | テンプレートファイルを検索する際の優先ディレクトリです。                      |                                 |      |
|                          | 独自テンプレートファイルを使用する場合に指定します。                          |                                 |      |
+--------------------------+-------------------------------------------------------------------------------+---------------------------------+------+
| globalFactoryClassName   | タスクで使用されるインスタンスを生成するファクトリの完全修飾名です。          | org.seasar.doma.                |      |
|                          | ``org.seasar.doma.extension.gen.GlobalFactory``                               | extension.gen.                  |      |
|                          | の実装クラスでなければいけません。                                            | GlobalFactory                   |      |
+--------------------------+-------------------------------------------------------------------------------+---------------------------------+------+

EntityConfig
============

エンティティクラスの生成に関する設定を表すデータ型です。

このデータ型を使用するとエンティティクラスとエンティティリスナークラスを生成できます。
エンティティクラスとエンティティリスナーは同じパッケージに生成されます。

``EntityConfig`` のパラメータ定義は次の通りです。

+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| パラメータ                   | 説明                                                                                     | デフォルト値  | 必須 |
+==============================+==========================================================================================+===============+======+
| generate                     | ``true`` の場合、エンティティクラスとエンティティリスナーの Java ファイルを生成します。  | true          |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| destDir                      | Java ファイルの出力先ディレクトリです。                                                  | src/main/java |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| encoding                     | Java ファイルのエンコーディングです。                                                    | UTF-8         |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| overwrite                    | ``true`` の場合、エンティティクラスのJavaコードを上書きします。                          | true          |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| overwriteListener            | ``true`` の場合、エンティティリスナークラスのJavaコードを上書きします。                  | false         |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| packageName                  | エンティティクラスのパッケージ名です。                                                   |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| entityPrefix                 | エンティティクラスのプリフィックスです。                                                 |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| superclassName               | エンティティクラスのスーパークラスの完全修飾名です。                                     |               |      |
|                              | 生成されるエンティティクラスはここに指定したスーパークラスを継承します。                 |               |      |
|                              | 指定するクラスは、Genタスクを実行するクラスパスに通されている必要があります。            |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| listenerSuperclassName       | エンティティリスナーのスーパークラスの完全修飾名です。                                   |               |      |
|                              |                                                                                          |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| namingType                   | ネーミング規約です。 ``none``,  ``snake_upper_case``,                                    |               |      |
|                              | ``snake_lower_case``, ``upper_case``, ``lower_case``                                     |               |      |
|                              | のいずれかの値を指定できます。 ``@Entity`` の ``naming`` 要素に使用されます。            |               |      |
|                              |                                                                                          |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| entityPropertyClassNamesFile | エンティティプロパティのクラス名を解決するためのファイルです。                           |               |      |
|                              | 形式は、キーをエンティティプロパティ名の正規表現、                                       |               |      |
|                              | 値をクラスの完全修飾名とするプロパティファイル形式です。                                 |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| generationType               | 識別子を生成する方法です。                                                               |               |      |
|                              | ``identity``, ``sequence``, ``table`` のいずれかを指定できます。                         |               |      |
|                              | ``identity`` と ``sequence`` については使用する RDBMS がサポート                         |               |      |
|                              | していない場合にエラーになります。                                                       |               |      |
|                              | この設定はテーブルが単一の主キーを持つ場合にのみ有効です。                               |               |      |
|                              | ``@GeneratedValue`` の ``strategy`` 要素に使用されます。                                 |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| initialValue                 | 識別子の初期値です。                                                                     |               |      |
|                              | ``generationType`` に ``sequence`` もしくは ``table`` を指定した場合にのみ有効です。     |               |      |
|                              | ``@SequenceGenerator`` や ``@TableGenerator`` の ``initialValue`` 要素に指定されます。   |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| allocationSize               | 割り当てサイズです。                                                                     |               |      |
|                              | ``generationType`` に ``sequence`` もしくは ``table`` を指定した場合にのみ有効です。     |               |      |
|                              | ``@SequenceGenerator`` や ``@TableGenerator`` の ``allocationSize`` 要素に指定されます。 |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| useAccessor                  | ``true`` の場合エンティティクラスにアクセッサメソッドを生成します。                      | true          |      |
|                              | ``false`` の場合エンティティクラスのフィールドは public になります。                     |               |      |
|                              |                                                                                          |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| useListener                  | ``true`` の場合エンティティリスナーのソースコードを生成し、                              | true          |      |
|                              | ``@Entity`` の ``listener`` 要素に指定します。                                           |               |      |
|                              | ``false`` の場合エンティティリスナーのソースコードは生成されません。                     |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| showDbComment                | ``true`` の場合 データベースのコメントを JavaDoc コメントに反映させます。                | true          |      |
|                              |                                                                                          |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| showCatalogName              | ``true`` の場合 ``@Table`` の ``catalog`` 要素にカタログ名を明記します。                 | false         |      |
|                              |                                                                                          |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| showSchemaName               | ``true`` の場合 ``@Table`` の ``schema`` 要素にスキーマ名を明記します。                  | false         |      |
|                              |                                                                                          |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| showTableName                | ``true`` の場合 ``@Table`` の ``name`` 要素にテーブル名を明記します。                    | true          |      |
|                              |                                                                                          |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| showColumnName               | ``true`` の場合 ``@Column`` の ``name`` 要素にカラム名を明記します。                     | true          |      |
|                              |                                                                                          |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| originalStatesPropertyName   | ここに指定した名前のプロパティに、 ``@OriginalStates`` を注釈します。                    |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| sql                          | この SQL の結果セットに対応したエンティティクラスのファイルを生成します。                |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+
| entityName                   | ``sql`` に値を指定した場合に有効です。                                                   | Example       |      |
|                              | SQL の結果セットに対応したエンティティクラスの名前になります。                           |               |      |
+------------------------------+------------------------------------------------------------------------------------------+---------------+------+

DaoConfig
=========

Dao インタフェースの生成に関する設定を表すデータ型です。

このデータ型を使用するとエンティティごとに1つの Dao インタフェースを生成できます。

``DaoConfig`` のパラメータ定義は次の通りです。

+-----------------+---------------------------------------------------------------------+---------------+------+
| パラメータ      | 説明                                                                | デフォルト値  | 必須 |
+=================+=====================================================================+===============+======+
| generate        | ``true`` の場合、 Dao インタフェースの Java ファイル を生成します。 | true          |      |
+-----------------+---------------------------------------------------------------------+---------------+------+
| destDir         | Java ファイルの出力先ディレクトリです。                             | src/main/java |      |
+-----------------+---------------------------------------------------------------------+---------------+------+
| encoding        | Java ファイルのエンコーディングです。                               | UTF-8         |      |
+-----------------+---------------------------------------------------------------------+---------------+------+
| overwrite       | ``true`` の場合、Dao インタフェースの Java ファイルを上書きします。 | false         |      |
+-----------------+---------------------------------------------------------------------+---------------+------+
| packageName     | Dao インタフェースのパッケージ名です。                              | example.dao   |      |
+-----------------+---------------------------------------------------------------------+---------------+------+
| suffix          | Dao インタフェースのサフィックスです。                              | Dao           |      |
|                 | Dao インタフェースの名前はエンティティクラス名にこのサフィックスを  |               |      |
|                 | を付与したものになります。                                          |               |      |
+-----------------+---------------------------------------------------------------------+---------------+------+
| configClassName | 設定クラスの完全修飾名です。                                        | false         |      |
|                 | ``@Dao`` の ``config`` 要素に指定されます。                         |               |      |
+-----------------+---------------------------------------------------------------------+---------------+------+

SqlConfig
=========

SQL ファイルの生成に関する設定を表すデータ型です。

このデータ型を使用するとエンティティごとにデフォルトで2つの SQL ファイルを生成できます。
生成される SQL は次のものです。

* 条件に識別子を指定して検索する SQL
* 条件に識別子とバージョンを指定して検索する SQL

ただし、エンティティが識別子を持たない場合は SQL ファイルは生成されません。
また、エンティティがバージョンを持たない場合は条件にバージョンを指定する SQLは生成されません。

テンプレートを用意することで、独自の SQL ファイルを生成できます。

``SqlConfig`` のパラメータ定義は次の通りです。

+------------+-----------------------------------------------+--------------------+------+
| パラメータ | 説明                                          | デフォルト値       | 必須 |
+============+===============================================+====================+======+
| generate   | ``true`` の場合、 SQL ファイルを生成します。  | true               |      |
+------------+-----------------------------------------------+--------------------+------+
| destDir    | SQL ファイルの出力先ディレクトリです。        | src/main/resources |      |
+------------+-----------------------------------------------+--------------------+------+
| overwrite  | ``true`` の場合、SQL ファイルを上書きします。 | true               |      |
+------------+-----------------------------------------------+--------------------+------+

SqlTestCaseConfig
=================

SQL のテストケースの生成に関する設定を表すデータ型です。

このデータ型を使用すると、ネストした要素として指定した ``FileSet`` にマッチした
SQL ファイルに対するテストケースを生成します。

``SqlTestCaseConfig`` のパラメータ定義は次の通りです。

+------------+----------------------------------------------------------------+---------------+------+
| パラメータ | 説明                                                           | デフォルト値  | 必須 |
+============+================================================================+===============+======+
| generate   | ``true`` の場合、SQL をテストする Java ファイル を生成します。 | true          |      |
+------------+----------------------------------------------------------------+---------------+------+
| destDir    | Java ファイルの出力先ディレクトリです。                        | src/test/java |      |
+------------+----------------------------------------------------------------+---------------+------+
| encoding   | Java ファイルのエンコーディングです。                          | UTF-8         |      |
+------------+----------------------------------------------------------------+---------------+------+

ネストした要素として指定される FileSet
--------------------------------------

テスト対象の SQL ファイルを指定するために ``FileSet`` を使用します。
SQL ファイルは次の条件を満たしていなければいけません。

* 拡張子が ``sql`` である
* ``META-INF`` ディレクトリ以下に配置される

設定例
======

Gradle_ で使用するための設定例を示します。

.. code-block:: groovy

  configurations {
      domaGenRuntime
  }

  repositories {
      mavenCentral()
      maven {url 'https://oss.sonatype.org/content/repositories/snapshots/'}
  }

  dependencies {
      domaGenRuntime 'org.seasar.doma:doma-gen:2.12.2-SNAPSHOT'
      domaGenRuntime 'org.postgresql:postgresql:9.3-1100-jdbc41'
  }

  task gen << {
      ant.taskdef(resource: 'domagentask.properties',
          classpath: configurations.domaGenRuntime.asPath)
      ant.gen(url: 'jdbc:postgresql://127.0.0.1/example', user: '', password: '') {
          entityConfig()
          daoConfig()
          sqlConfig()
      }
  }

  task genTestCases << {
      ant.taskdef(resource: 'domagentask.properties',
          classpath: configurations.domaGenRuntime.asPath)
      ant.gen(url: 'jdbc:postgresql://127.0.0.1/example', user: '', password: '') {
          sqlTestCaseConfig {
              fileset(dir: 'src/main/resources') {
                  include(name: 'META-INF/**/*.sql')
              }
          }
      }
  }

設定のポイントは次のものです。

* ``configurations`` と ``dependencies`` で Doma-Gen と JDBC ドライバへの依存関係を示す
* ``ant.taskdef`` の ``classpath`` に ``configurations`` に追加した名前を指定する
* ``ant.taskdef`` の ``resource`` に ``domagentask.properties`` を指定する

使用例
======

すべて Gradle_ で使用する例です。

データベースのメタデータからファイル一式を生成する
--------------------------------------------------

次のタスクにより、
エンティティクラス、エンティティリスナークラス、 Dao インタフェース、SQL のファイル一式を生成できます。

.. code-block:: groovy

  task gen << {
      ant.taskdef(resource: 'domagentask.properties',
          classpath: configurations.domaGenRuntime.asPath)
      ant.gen(url: 'jdbc:postgresql://127.0.0.1/example', user: '', password: '') {
          entityConfig()
          daoConfig()
          sqlConfig()
      }
  }

SQL の実行結果からエンティティクラスのファイルを生成する
--------------------------------------------------------

``EntityConfig`` データ型の ``sql`` パラメータに SQL を指定すると
結果セットのメタデータを使って SQL の結果に対応するエンティティティクラスのファイルを生成できます。

``packageName`` と ``entityName`` のパラメータも合わせて設定すると良いでしょう。

.. code-block:: groovy

  task genEntity << {
      ant.taskdef(resource: 'domagentask.properties',
          classpath: configurations.domaGenRuntime.asPath)
      ant.gen(url: 'jdbc:postgresql://127.0.0.1/example', user: '', password: '') {
          entityConfig(packageName: 'aaa.bbb',
              entityName: 'GroupByDeptId',
              sql: 'select dept_id, max(age) as max_age from emp group by dept_id')
      }
  }

上記のタスクを実行すると以下の出力を得られます。

.. code-block:: java

  package aaa.bbb;

  import org.seasar.doma.Column;
  import org.seasar.doma.Entity;

  @Entity
  public class GroupByDeptId {

      /** */
      @Column(name = "DEPT_ID")
      Integer deptId;

      /** */
      @Column(name = "MAX_AGE")
      Integer age;

      ...
  }

上記の例では、パラメータをビルドスクリプトに埋め込んでいますが、
gradle コマンド の -P オプションを使って外部から値を渡すこともできます。

.. code-block:: bash

  $ gradle genEntity -PentityName="GroupByDeptId" -Psql="select dept_id, max(age) from emp group by dept_id"

.. code-block:: groovy

  task genEntity << {
      ant.taskdef(resource: 'domagentask.properties',
          classpath: configurations.domaGenRuntime.asPath)
      ant.gen(url: 'jdbc:postgresql://127.0.0.1/example', user: '', password: '') {
          entityConfig(packageName: 'aaa.bbb',
              entityName: entityName,
              sql: sql)
      }
  }

ディレクトリ中の SQL ファイルを検出し SQL のテストケースを生成する
------------------------------------------------------------------

次のタスクにより、
ディレクトリ中の SQL ファイルを検出し SQL のテストケースを生成します。

.. code-block:: groovy

  task genTestCases << {
      ant.taskdef(resource: 'domagentask.properties',
          classpath: configurations.domaGenRuntime.asPath)
      ant.gen(url: 'jdbc:postgresql://127.0.0.1/example', user: '', password: '') {
          sqlTestCaseConfig {
              fileset(dir: 'src/main/resources') {
                  include(name: 'META-INF/**/*.sql')
              }
          }
      }
  }

エンティティのプロパティのクラス名を指定する
--------------------------------------------

ドメインクラスを使用する場合など、特定のエンティティプロパティに対しクラス名を指定したいことがあります。

クラス名の指定は、 properties ファイルで行います。
キーは、エンティティプロパティの完全修飾名を正規表現で表したもの、値はマッピングしたいクラスの完全修飾名です。
エンティティプロパティの完全修飾名とは、「エンティティクラスの完全修飾名」と「エンティティプロパティ名」を「@」で連結したものです。
たとえば、 ``Employee`` エンティティクラスのエンティティプロパティ ``employeeName`` の完全修飾名は、
``example.entity.Employee@employeeName`` です。

``Employee`` エンティティクラスの中でエンティティプロパティ名が ``Name`` で終わるものを
``example.domain.Name`` クラスにマッピングさせるには次のように記述します。

.. code-block:: properties

  example.entity.Employee@.*Name$=example.domain.Name

プロパティ名の部分を正規表現で示しています。
正規表現はプロパティ名に対してのみ使用できます（@より左のクラス名は必ず完全修飾名でなければいけません）。

生成されるエンティティクラスでは、次のように ``employeeName`` プロパティの型が ``example.domain.Name`` になります。

.. code-block:: java

  import example.domain.Name;

  @Entity
  public class Employee {
      @Id
      Integer id;
      Name employeeName;
      ...
  }

``Employee`` エンティティクラスに限らず、すべてのエンティティクラスを対象にエンティティプロパティ名が ``Name`` で終わるものを
``example.domain.Name`` クラスにマッピングさせたい場合は次のように記述します。

.. code-block:: properties

  .*Name$=example.domain.Name

properties ファイルは、エンティティプロパティごとに上から順番に評価され、正規表現がマッチした時点で評価を終えます。
どの行にもマッチしない場合、クラス名はデフォルトのクラス名になります。

properties ファイルは ``EntityConfig`` データ型の ``entityPropertyClassNamesFile`` パラメータに指定できます。
（ここではプロパティファイルの名前を ``name.properties`` とします。）

.. code-block:: groovy

  task gen << {
      ant.taskdef(resource: 'domagentask.properties',
          classpath: configurations.domaGenRuntime.asPath)
      ant.gen(url: 'jdbc:postgresql://127.0.0.1/example', user: '', password: '') {
          entityConfig(entityPropertyClassNamesFile: 'name.properties')
          daoConfig()
          sqlConfig()
      }
  }

独自のテンプレートファイルを使用する
------------------------------------

Doma-Gen のテンプレートは、ソースコードリポジトリの src/main/resources/template ディレクトリ以下にあります。
テンプレートの種類を以下に示します。

+-------------------------------+--------------------------------------------------+--------------------------------------------+
| テンプレート                  | データモデルクラス                               | 生成物                                     |
+===============================+==================================================+============================================+
| entity.ftl                    | org.seasar.doma.extension.gen.EntityDesc         | エンティティクラスの Java ファイル         |
+-------------------------------+--------------------------------------------------+--------------------------------------------+
| entityListener.ftl            | org.seasar.doma.extension.gen.EntityListenerDesc | エンティティリスナークラスの Java ファイル |
+-------------------------------+--------------------------------------------------+--------------------------------------------+
| dao.ftl                       | org.seasar.doma.extension.gen.DaoDesc            | Dao インタフェースの Java ファイル         |
+-------------------------------+--------------------------------------------------+--------------------------------------------+
| sqlTestCase.ftl               | org.seasar.doma.extension.gen.SqlTestCaseDesc    | SQL をテストするクラスの Java ファイル     |
+-------------------------------+--------------------------------------------------+--------------------------------------------+
| xxx.sql.ftl (xxxは任意の名称) | org.seasar.doma.extension.gen.SqlDesc            | SQL ファイル                               |
+-------------------------------+--------------------------------------------------+--------------------------------------------+

これらのファイルをコピーして修正を加えてください。
テンプレートの記法については FreeMarker_ のドキュメントを参照してください。

修正したテンプレートファイルは、ファイル名を変更せずに ``templatePrimaryDir`` パラメータに指定するディレクトリに配置します。
たとえば、 変更したテンプレートを mytemplate ディレクトリに配置する場合は
``templatePrimaryDir`` パラメータに mytemplate を指定します。

.. code-block:: groovy

  task gen << {
      ant.taskdef(resource: 'domagentask.properties',
          classpath: configurations.domaGenRuntime.asPath)
      ant.gen(url: 'jdbc:postgresql://127.0.0.1/example', user: '', password: '',
          templatePrimaryDir: 'mytemplate') {

          entityConfig()
          daoConfig()
          sqlConfig()
      }
  }

生成するJavaファイルに共通のヘッダーとしてコピーライトを含める
--------------------------------------------------------------

``lib.ftl`` というファイルを作成し、これを ``templatePrimaryDir`` パラメータに指定するディレクトリに配置します。
``lib.ftl`` には次のようにcopyrightの定義をします。

.. code-block:: xml

  <#assign copyright>
  /*
   * Copyright 2008-2009 ...
   * All rights reserved.
   */
  </#assign>

``lib.ftl`` を mytemplate ディレクトリに配置する場合、タスクの定義は次のようになります。

.. code-block:: groovy

  task gen << {
      ant.taskdef(resource: 'domagentask.properties',
          classpath: configurations.domaGenRuntime.asPath)
      ant.gen(url: 'jdbc:postgresql://127.0.0.1/example', user: '', password: '',
          templatePrimaryDir: 'mytemplate') {

          entityConfig()
          daoConfig()
          sqlConfig()
      }
  }

生成するJavaファイルにauthorを指定する
--------------------------------------

``lib.ftl`` というファイルを作成し、これを ``templatePrimaryDir`` パラメータに指定するディレクトリに配置します。
``lib.ftl`` には次のように author の定義をします。

.. code-block:: xml

  <#assign author="Nakamura">

``lib.ftl`` を mytemplate ディレクトリに配置する場合、タスクの定義は次のようになります。

.. code-block:: groovy

  task gen << {
      ant.taskdef(resource: 'domagentask.properties',
          classpath: configurations.domaGenRuntime.asPath)
      ant.gen(url: 'jdbc:postgresql://127.0.0.1/example', user: '', password: '',
          templatePrimaryDir: 'mytemplate') {

          entityConfig()
          daoConfig()
          sqlConfig()
      }
  }


.. links
.. _Gradle: http://www.gradle.org/
.. _FreeMarker: http://freemarker.org/
