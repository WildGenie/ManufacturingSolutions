﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;
using QA.Core;
using QA.Model;

namespace QA.Rule
{
    public class CustomRule : IRule
    {
        public string FieldName { get; set; }
        public string GroupName { get; set; }
        public string ExpectedValue { get; set; }
        public string[] QuotedFields { get; set; }

        public bool Check(IDictionary<string, object> Pairs, out object Result)
        {
            Result result = new Result()
            {
                FieldName = FieldName,
                RuleType = RuleType.Custom,
                RuleInstance = new ValidationRuleItem()
                {
                    FieldName = FieldName,
                    GroupName = GroupName,
                    RuleType = RuleType.Custom,
                    FieldValue = ExpectedValue,
                    QuotedFields = QuotedFields
                }
            };

            Result = result;

            try
            {
                if (Pairs == null)
                {
                    result.IsPassed = false;
                    return false;
                }

                if (!Pairs.ContainsKey(FieldName))
                {
                    result.IsPassed = false;
                    return false;
                }

                result.FieldValue = Pairs[FieldName];
                result.IsPassed = Regex.IsMatch((string)Pairs[FieldName], ExpectedValue, RegexOptions.None); //((string)Pairs[FieldName] == ExpectedValue);

                if (QuotedFields != null)
                {
                    result.Description = new Dictionary<string, object>();

                    foreach (string field in QuotedFields)
                    {
                        if (Pairs.ContainsKey(field))
                        {
                            (result.Description as Dictionary<string, object>).Add(field, Pairs[field]);
                        }
                    }
                }

                return result.IsPassed;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}