// Copyright © 2020-present, Michael Cummings
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// MIT License
//
// Copyright © 2020-present, Michael Cummings <mgcummings@yahoo.com>.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

use cargo_metadata::MetadataCommand;
use serde::{Deserialize, Serialize};
use std::{env, fs};

#[derive(Clone, Debug, Deserialize, Serialize)]
pub struct Config {
    pub database: Option<String>,
    pub url: Option<String>,
    pub mysql: Option<MysqlConfig>,
    pub postgres: Option<PostgresConfig>,
    pub sqlite: Option<SqliteConfig>,
}

#[derive(Clone, Debug, Deserialize, Serialize)]
pub struct MysqlConfig {
    pub database: Option<String>,
    pub url: Option<String>,
}

#[derive(Clone, Debug, Deserialize, Serialize)]
pub struct PostgresConfig {
    pub database: Option<String>,
    pub url: Option<String>,
}

#[derive(Clone, Debug, Deserialize, Serialize)]
pub struct SqliteConfig {
    pub url: Option<String>,
}

impl Config {
    pub fn from_crate_cargo_toml() -> Option<Config> {
        let metadata = MetadataCommand::new().no_deps().exec().ok()?;
        let prs =
            metadata.workspace_metadata.get("person_rust_skeleton").or_else(
                || metadata.packages[0].metadata.get("person_rust_skeleton"),
            )?;
        serde_json::from_value::<Config>(prs.to_owned()).ok()
    }
    pub fn from_prs_toml() -> Option<Config> {
        let cwd = env::current_dir().ok()?;
        let files = vec!["config/prs.toml", ".prs.toml", "prs.toml"];
        let mut config = None;
        for file in files {
            let file_path = cwd.clone().join(file);
            let contents = fs::read_to_string(file_path.as_path());
            if let Ok(s) = contents {
                config = toml::from_str::<Config>(s.as_str()).ok();
                break;
            }
        }
        config
    }
}
