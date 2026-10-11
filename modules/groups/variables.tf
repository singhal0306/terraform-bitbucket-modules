/**
 * Copyright 2026 Suryansh Singhal
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "auto_add" {
  description = "Whether to automatically add repositories."
  type        = bool
  default     = false
}

variable "name" {
  description = "The name of the Bitbucket project."
  type        = string
}

variable "permissions" {
  description = "A map where the key is the repository name and the value is another map of group slugs to permission levels."
  type        = string
  default     = null
}

variable "workspace" {
  description = "The slug or UUID of the workspace."
  type        = string
}
