﻿using System.Reflection;

namespace CleanArchitecture.Presentation;

public class AssemblyReference
{
    public static readonly Assembly Assembly = typeof(AssemblyReference).Assembly;
}
