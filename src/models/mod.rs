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
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#[cfg(feature = "mysql")]
mod mysql;
#[cfg(feature = "postgres")]
mod postgres;
#[cfg(feature = "sqlite")]
mod sqlite;

use crate::schema::people;
use chrono::NaiveDateTime;
use rand::rngs::ThreadRng;
use serde::{Deserialize, Serialize};
use uuid64rs::Uuid4;
// Remember BREAD not CRUD!!!

#[derive(
    AsChangeset, Debug, Deserialize, Identifiable, Insertable, PartialEq, Queryable, Serialize,
)]
#[table_name = "people"]
pub struct Person {
    pub id: Uuid4,
    pub additional_name: Option<Option<String>>,
    pub birthday: Option<Option<NaiveDateTime>>,
    pub family_name: String,
    pub gender_id: Option<Option<Uuid4>>,
    pub given_name: String,
    pub honorific_prefix: Option<Option<String>>,
    pub honorific_suffix: Option<Option<String>>,
    pub pronoun_id: Option<Option<Uuid4>>,
    #[cfg(feature = "created_at")]
    pub created_at: NaiveDateTime,
    #[cfg(feature = "updated_at")]
    pub updated_at: NaiveDateTime,
    #[cfg(feature = "updated_by")]
    pub updated_by: Uuid4,
}

#[derive(Debug, Deserialize, Identifiable, Insertable, PartialEq, Serialize)]
#[table_name = "people"]
pub struct AddPerson {
    id: Uuid4,
    pub additional_name: Option<Option<String>>,
    birthday: Option<Option<NaiveDateTime>>,
    pub family_name: String,
    gender_id: Option<Option<Uuid4>>,
    pub given_name: String,
    honorific_prefix: Option<Option<String>>,
    honorific_suffix: Option<Option<String>>,
    pronoun_id: Option<Option<Uuid4>>,
}

impl AddPerson {
    pub fn new<'a, TR>(rng: TR, given_name: &str, family_name: &str) -> Self
    where
        TR: Into<Option<&'a mut ThreadRng>>,
    {
        Self {
            id: Uuid4::new(rng),
            additional_name: None,
            birthday: None,
            family_name: family_name.to_string(),
            gender_id: None,
            given_name: given_name.to_string(),
            honorific_prefix: None,
            honorific_suffix: None,
            pronoun_id: None,
        }
    }
    pub fn set_birthday<T>(&mut self, value: T)
    where
        T: Into<Option<NaiveDateTime>>,
    {
        self.birthday = value.into().into();
    }
    pub fn set_gender_id<T>(&mut self, value: T)
    where
        T: Into<Option<Uuid4>>,
    {
        self.gender_id = value.into().into();
    }
    pub fn set_honorific_prefix<T>(&mut self, value: T)
    where
        T: Into<Option<String>>,
    {
        self.honorific_prefix = value.into().into();
    }
    pub fn set_honorific_suffix<T>(&mut self, value: T)
    where
        T: Into<Option<String>>,
    {
        self.honorific_suffix = value.into().into();
    }
    pub fn set_pronoun_id<T>(&mut self, value: T)
    where
        T: Into<Option<Uuid4>>,
    {
        self.pronoun_id = value.into().into();
    }
}
